require 'nokogiri'
require 'open-uri'


module Dem
	class Client
	
		@@doc = Nokogiri::XML(open("https://iemweb.biz.uiowa.edu/quotes/365.html"))

		# search = doc.search('__')
		# @democrats = []

		# @columns = []
		# for i in 0..6 do
		# 	@columns.push(doc.search('TR')[0].children.children[i].text)
		# end

		# @dems = []
		# for i in 0..3 do
		# 	@dems.push([doc.search('TR')[i].children.children.text])
		# end


		# @clin = []
		# for i in 0..6 do
		# 	@clin.push(doc.search('TR')[1].children.children[i].text)
		# end

		# @sand = []
		# for i in 0..6 do
		# 	@sand.push(doc.search('TR')[2].children.children.text)
		# end

		# @d_rof = []
		# @d_rof.push(doc.search('TR')[3].children.children.text)

		# this function defines an array to hold each of the candidates data,
		# it then loops through for the number of rows in the table and puts each datapoint into the
		# an array thats then pushed to the candidates data array
		def get_data
			@democrat_candidate = []
			for i in 0..3 do
				cand = Array.new
				for x in 0..6 do
					cand.push(@@doc.search('TR')[i].children.children[x].text)
				end
				@democrat_candidate.push(cand)
			end

			@columns = @democrat_candidate[0]
			@democrats = []
			for i in 1..3 do
				c = Hash[@columns.zip @democrat_candidate[i]]
				@democrats.push(c)
			end
			return @democrats
		end

	end
end