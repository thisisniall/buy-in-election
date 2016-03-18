class Candidate < ActiveRecord::Base
	has_many :transactions

	def self.d_get_data
		require 'open-uri'
		doc = Nokogiri::XML(open("https://iemweb.biz.uiowa.edu/quotes/365.html"))

		@democrat_candidate = []
		for i in 0..3 do
			cand = Array.new
			for x in 0..6 do
				cand.push(doc.search('TR')[i].children.children[x].text)
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

	def self.r_get_data
		require 'open-uri'
		doc = Nokogiri::XML(open("https://iemweb.biz.uiowa.edu/quotes/364.html"))

		@republican_candidate = []
		for i in 0..5 do
			cand = Array.new
			for x in 0..6 do
				cand.push(doc.search('TR')[i].children.children[x].text)
			end
			@republican_candidate.push(cand)
		end

		@columns = @republican_candidate[0]
		@republicans = []
		for i in 1..5 do
			cand = Hash[@columns.zip @republican_candidate[i]]
			@republicans.push(cand)
		end
		return @republicans
	end
end
