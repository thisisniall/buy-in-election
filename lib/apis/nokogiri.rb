require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("https://iemweb.biz.uiowa.edu/quotes/365.html"))
doc.xpath('//tr/td').each do |node|
	puts node.text
end


# module Dem
# 	class Data

# 	def initialize
# 		@uri = 'https://iemweb.biz.uiowa.edu/quotes/365.html'
# 	end

# 	def make_request
# 		XML.parse(Nokogiri::HTML.get(URI(@uri)))
# 	end


# # dem_data = open('https://iemweb.biz.uiowa.edu/quotes/365.html').read
# # nokogiri_object = Nokogiri::HTML(dem_data)
# # table_elements = nokogiri_object.xpath("//tr[1]/td")

# # table_elements.each do |table_element|
# # 	puts table_element.text
# end