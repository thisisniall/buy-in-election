require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

# this is how we request the page we're going to scrape
page = HTTParty.get('https://iemweb.biz.uiowa.edu/quotes/364.html')

#this is where we change the http response into a nokogiri object
parse_page = Nokogiri::HTML(page)

#empty array where we store data we scrape
candidates_array= []
carson_array= []
cruz_array=[]
rubio_array=[]
trump_array=[]


# this is where we parse the data
parse_page.css('//td')
# one-line ugly display of entire table
# puts parse_page.css("td").text
# puts parse_page.css("tr").text

# these are the individual data points


	carson_array.push(parse_page.css("td")[7].text)
	carson_array.push(parse_page.css("td")[8].text)
	carson_array.push(parse_page.css("td")[9].text)
	carson_array.push(parse_page.css("td")[10].text)
	carson_array.push(parse_page.css("td")[11].text)
	carson_array.push(parse_page.css("td")[12].text)
	carson_array.push(parse_page.css("td")[13].text)
	cruz_array.push(parse_page.css("td")[14].text)
	cruz_array.push(parse_page.css("td")[15].text)
	cruz_array.push(parse_page.css("td")[16].text)
	cruz_array.push(parse_page.css("td")[17].text)
	cruz_array.push(parse_page.css("td")[18].text)
	cruz_array.push(parse_page.css("td")[19].text)
	cruz_array.push(parse_page.css("td")[20].text)
	rubio_array.push(parse_page.css("td")[21].text)
	rubio_array.push(parse_page.css("td")[22].text)
	rubio_array.push(parse_page.css("td")[23].text)
	rubio_array.push(parse_page.css("td")[24].text)
	rubio_array.push(parse_page.css("td")[25].text)
	rubio_array.push(parse_page.css("td")[26].text)
	rubio_array.push(parse_page.css("td")[27].text)
	trump_array.push(parse_page.css("td")[28].text)
	trump_array.push(parse_page.css("td")[29].text)
	trump_array.push(parse_page.css("td")[30].text)
	trump_array.push(parse_page.css("td")[31].text)
	trump_array.push(parse_page.css("td")[32].text)
	trump_array.push(parse_page.css("td")[33].text)
	trump_array.push(parse_page.css("td")[34].text)


puts carson_array
puts cruz_array
puts rubio_array
puts trump_array


#displays by row of table
# data = parse_page.css("tr")[1].text
# carson_array.push(data)
# data = parse_page.css("tr")[2].text
# cruz_array.push(data)

# candidates_array.push(carson_array, cruz_array)
# puts candidates_array


# puts candidates_array[1]
# puts candidates_array[0]

# Pry.start(binding)


#puts parse_page.css("td")[10].text
	# get individual pieces of data from the above statement
	# send these pieces 