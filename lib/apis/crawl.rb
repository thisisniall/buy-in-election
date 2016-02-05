require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

module Crawl
	class Rep

		def initialize
			page = HTTParty.get('https://iemweb.biz.uiowa.edu/quotes/364.html')
		end

		

	end
end  