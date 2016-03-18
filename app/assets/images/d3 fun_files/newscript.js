$(document).ready(function(){

	var location

	var tables = [
		"B01001", //age by sex
		"B14001", //current enrollment by age education
		"B19001", //household income 1 year
		"B02001"  //race
		];

	var len = tables.length;

	$('#select').on('click', function(){
		clear();
		
		var location = $("#locSelect").val();
		var location = String(location);
		var table = tables[0];
		titleIt(location, table);

	function titleIt(location, table, len){	
		d3.json("http://api.censusreporter.org/1.0/data/show/latest?table_ids=" + table + "&geo_ids="+location, function(error,response) {
			var locationN = response.geography[location]['name'];
			console.log(locationN);
			$('#locationName').animate({
				left: '-25%',
			});
			$('#locationName').append("<h2>" + locationN + "</h2>");
			
		});
	};


	for(var i = 0; i < tables.length; i++){
		var table = tables[i];
		var location = $("#locSelect").val();
		var location = String(location);
		
		// calls function that finds the location of the first table and posts it to the page
		chartIt(location, table);
		
		function chartIt(location, table){


			d3.json("http://api.censusreporter.org/1.0/data/show/latest?table_ids=" + table + "&geo_ids="+location, function(error,response) {
		  	var data = response.data[location][table].estimate;
		  
			keyArray = [];
			valueArray = [];
			for (value in data) {
			    if (data.hasOwnProperty(value)) {
			        valueArray.push(data[value]); 
			        // Push the key's value on the array
			    }
			}
			// sets a variable for the titles of the graphs
		  	var title = response.tables[table].title;

		  	// sets a variable for the bar labels
			var labels = response.tables[table].columns;

		  	for (key in labels) {
		  		// keyArray.push(labels[key]);
		  		keyArray.push(labels[key]['name']);
		  	}

			// create an empty dataset array variable for d3
			var dataset = [];

			// loop through keyArray (array of keys) and valueArray(array of values) to create object instances
			for(var i = 1; i < keyArray.length; i++){
				var item = new Object();
					item.key = keyArray[i];
					item.value = valueArray[i];
					dataset.push(item);
			};

			console.log(dataset);
			// calls the function that actually builds the charts
			visualizeIt(dataset, title);

			});
		};
	};
});
// this function constructs the charts
function visualizeIt(dataset, title) {
	// set a variable the longest chart column label, to be used for defining the length of the area alloted for labels
	var bot = d3.max(dataset, function(d) {return d.key.length; } );

	// sets the margins for the svg
	var margin = {
		top: 70, 
		right: 10, 
		bottom: (bot + 20),
		left: 100
	};
	
	var width = 850 - margin.left - margin.right;
	var height = 550 - margin.top - margin.bottom;
	var w = width;
	var h = height;

	//create a div for the svg to live inside
	// var divG = d3.selectAll("body")
	// 	.append("div")
	// 	.attr("class", "graphDiv")
		
	
	//Create the SVG element
	
	var svg = d3.select("#graph")
		.append("svg")
		.attr("class", "svg")
		.attr("width", w + margin.left + margin.right)
		.attr("height", h + margin.top + margin.bottom)
		
	

	//Define the X scale
	var xScale = d3.scale.ordinal()
		.domain(dataset.map(function (d){return d.key;}))
		.rangeRoundBands([margin.left, w], 0.05);

	//Define the X Axis
	var xAxis = d3.svg.axis()
		.scale(xScale)
		.orient("bottom");

	//Define the Y Scale
	var yScale = d3.scale.linear()
		.domain([0, d3.max(dataset, function(d) {return d.value; } )])
		.range([h, margin.top]);

	//Define the Y Axis
	var yAxis = d3.svg.axis()
		.scale(yScale)
		.orient("left");

	// creates bars
	bars = svg.selectAll("rect").data(dataset);
	
	// creates labels (for bars)
	barLabels = svg.selectAll("text").data(dataset);
	
	// add new bars
	bars.enter()
		.append("rect")
		.attr("x", function(d, i) { 
			return xScale(d.key); 
		})
		.attr("y", function(d) {
			return yScale(d.value);
		})
		.attr("width", xScale.rangeBand())
		.attr("height", function(d) {
			return h - yScale(d.value);
		})
		// .attr("transform", "translate(105, 0)")
		.attr("fill", "#024E83");

	// display popups when you scroll over a bar
	bars.on("mouseover", function(d){

		svg.append("text")
			.attr("id", "info");

		// get the x and y positions for the popup in question
		var xPos = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand()/2;
		var yPos = parseFloat(d3.select(this).attr("y")) + 18;
		
		// add the actual info
		svg.select("#info")
			.attr("x", xPos)
			.attr("y", function(){
				// if the bar is very small, diplay the tooltip above it instead of trying to cram it inside
				var x = d3.max(dataset, function(d) { return d.value; });
				if (d.value < 0.1 * x) {
					return yPos - 22;
				} else {
					return yPos;
				};
			})
			.attr("text-anchor", "middle")
			.style("font-family", "Lato")
			.attr("fill", function(){
				// change the color of the info based on where it's going to be displayed(if the value is small, make it a darker color since it'll be on the white background)
				var x = d3.max(dataset, function(d) { return d.value; });
				if (d.value < 0.1 * x) {
					return "#2B3E42";
				} else {
					return "#ffffff";
				};
			})
			// .attr("padding", function(){
			// 	if(xScale.rangeBand() < 25){
			// 		return "10px";
			// 	} else {
			// 		return "0px";
			// 	};
			// })
			.attr("font-size", "12px")
			.text(d.value);
	})
	.on("mouseout", function(){
		d3.select("#info").remove();
	});
		

	// draw the X axis
	svg.append("g")
		.attr("class", "xaxis")
		.attr("transform", "translate(0," + h + ")")
		.call(xAxis)
		.selectAll("text")
		.style("text-anchor", "end")
		.style("font-family", "Lato")
		.attr("dx", "-.8em")
		.attr("dy", ".15em")
		.attr("transform", "rotate(-65)")
		.text(function(d){
			if(d.length > 15){
				return d.substr(0, 15) + "...";
			} else {
				return d;
			}
		});

	//draw the Y axis
	// svg.append("g")
	// 	.attr("class", "yaxis")
	// 	.attr("transform", "translate(" + margin.left + ",0)")
	// 	.call(yAxis);

	// add the X axis label
	svg.append("text")
		.attr("class", "xaxislabel graphlabel")
		.attr("text-anchor", "middle")
		.attr("transform", "translate(" + (w/2) + "," + (h + (margin.bottom / 2) + 60) + ")")
		// .text("Educational Level");

	// add Y Axis label
	svg.append("text")
		.attr("class", "yaxislabel graphlabel")
		.attr("text-anchor", "middle")
		.attr("transform", "translate(15," + (h / 2) + ")rotate(-90)")
		// .text("Number of People Enrolled");

	// add Title for chart
	svg.append("text")
		.attr("class", "chartTitle graphlabel")
		.attr("text-anchor", "middle")
		.attr("transform", "translate(" + ((w/2)+ 60) + ", 40)")
		.style("font-family", "Lato")
		.text(title);

		donutIt(dataset, title);
}

	function donutIt(dataset, title){

		var margin = {
		top: 20, 
		right: 10, 
		bottom: 20,
		left: 10
		};
		
		var width = 400 - margin.left - margin.right;
		var height = 550 - margin.top - margin.bottom;
		var w = width;
		var h = height;

		var radius = Math.min(width, height) / 2;

		var currentVal;

		var color = d3.scale.ordinal()
			.range(["#F6776A", "#024E83", "#97DCDD", "#DC4032", "#78C652"]);
			
		var pie = d3.layout.pie()
			.sort(null)
			.value(function(d) { return d.value });

		//Create the SVG element
		
		var arc = d3.svg.arc()
			.outerRadius(radius - 10)
			.innerRadius(radius - (radius/2.5));

		var svg = d3.select("#tables")
			.append("svg")
			.attr("class", "svg donut1")
			.attr("width", w)
			.attr("height", h + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + width /2 + "," + ((height/ 2) + 50) + ")");
		var newtitle
		function ntitle(d){
			console.log(d);
			if(d.length > 35){
				var s = d.substr(29, 37);
				var v = s.replace(/\s/, "\n");
				var Ttitle = d.replace(s, v);
				// console.log(ntitle);
				return Ttitle;
			} else {
				return title;
			};
		};

		newtitle = ntitle(title);
		console.log(newtitle)

		svg.append("text")
			.attr("width", width/ 2)
			.attr("class", "chartTitle graphlabel")
			.attr("text-anchor", "middle")
			.attr("transform", "translate( 0 , -200)")
			.style("font-family", "Lato")
			.text(newtitle);
			
		var g = svg.selectAll(".arc")
			.data(pie(dataset))
			.enter()
			.append("g")
			.attr("class", "arc");

		g.append("path")
			// Attach current value to g so it can be used for animation
			.each(function(d) { this._current = d; })
			.attr("d", arc)
			.style("fill", function(d) { return color(d.data.key); });

		// g.append("text")
		// 	.attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
		// 	.attr("dy", ".35em")
		// 	.style("text-anchor", "middle");

		// g.select("text")
		// 	.text(function(d) { return d.data.key; });

		svg.append("text")
			.datum(dataset.key)
			.attr("x", 0)
			.attr("y", 0 + radius/30)
			.attr("class", "text-info1")
			.style("text-anchor", "middle")
			.attr("font-weight", "bold")
			.style("font-size", radius/10+"px");

		svg.append("text")
			.datum(dataset.key)
			.attr("x", 0)
			.attr("y", 0 + radius/8)
			.attr("class", "text-info2")
			.style("text-anchor", "middle")
			.attr("font-weight", "bold")
			.style("font-size", radius/12+"px");

		g.on("mouseover", function(obj){
			console.log(obj)
			svg.select("text.text-info1")
				.attr("fill", "#000000")
				.text(function(d){
					console.log([obj.data.key]);
					return [obj.data.key];
				});
			
			svg.select("text.text-info2")
				.attr("fill", function(d) { return color(obj.data.key); })
				.text(function(d){
					return [obj.value];
				});
				// .attr("transform", "translate(0, 20)");
		});

		g.on("mouseout", function(obj){
			svg.select("text.text-info1").text("");
			svg.select("text.text-info2").text("");
		});

		
		


		// svg.append("g")
		// 	.attr("class", "table_title")
		// 	.append("text")
		// 	.attr("transform", "translate(0, 50)")
		// 	.text(title);
			
		// svg.append("g")
		// 	.attr("width", width / 2)
		// 	.attr("height", h - margin.top - margin.bottom)
		// 	.attr("fill", "red")
		// 	.attr("class", "col1")
		// 	.append("ul")
		// 	.attr("class", "ul1")
		// 	.append("li")
		// 	.append("text");
			


			// .text(dataset.map(function (d){return d.key;}));
		
			// for(var i = 0; i < dataset.length; i++){
			// 	$(".ul1").append("<li>" + dataset[i].key + "</li>");
			// };
		

		// svg.append("g")
		// 	.attr('class', "col2")
		// 	.append("ul")
		// 	.attr("class", "ul2");

	}

	function clear(){
		d3.selectAll("svg").remove();
		$("h2").remove();
		$(".svgDiv").remove();
		$(".pieSideDiv").remove();
	};
});

			
