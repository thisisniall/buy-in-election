// js file for the d3 graph on the main page

// sets the width and height of the graph
var width = 960,
	height = 500;

// sets the scale of the y axis
var y = d3.scale.linear()
	// rather than hard coding in each of the lengths from an array, this allows the graph to be updated easily
	.range([height, 0]);

// selects the graph div and addigns it and its attributes equal to the preset variables
var graph = d3.select(".graph")
	.attr("width", width)
	.attr("height", height);

// tsv = 
// this is where all of the data comes in to play
// grabs from a tsv file called data.tsv

d3.tsv("data.tsv", type, function(error, data) {
	y.domain([0, d3.max(data, function(d) { return d.value; })]);

	var barWidth = width / data.length;

	var bar = chart.selectAll("g")
		.data(data)
	.enter().append("g")
		.attr("transform", function(d, i,) { return "translate(" + i * barWidth + ",0)";});

	bar.append("rect")
		.attr("x", barWidth / 2)
		.attr("y", function(d) { return y(d.value); })
		.attr("width", barWidth - 1);

	bar.append("text")
})