require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("https://iemweb.biz.uiowa.edu/quotes/365.html"))
doc.xpath('//tr/td').each do |node|
	puts node.text
end



class DemData

	attr_reader :url, :data

	def initialize(url)
		@url = url
	end

	# def make_request
	# 	XML.parse(Nokogiri::HTML.get(URI(@uri)))
	# end

	def get_data(node)
		data.css(node)
	end

	def data
		@data ||= Nokogiri::HTML(open(url))
	end

# dem_data = open('https://iemweb.biz.uiowa.edu/quotes/365.html').read
# nokogiri_object = Nokogiri::HTML(dem_data)
# table_elements = nokogiri_object.xpath("//tr[1]/td")

# table_elements.each do |table_element|
# 	puts table_element.text
end