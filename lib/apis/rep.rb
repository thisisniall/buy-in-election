require 'nokogiri'
require 'open-uri'


module Rep
	class Client
@@doc = Nokogiri::XML(open("https://iemweb.biz.uiowa.edu/quotes/364.html"))

# search = doc.search('__')
# @republicans = []

# @columns = doc.search('TR')[0].children.children.text
# @carson = doc.search('TR')[1].children.children.text
# @cruz = doc.search('TR')[2].children.children.text
# @rubio = doc.search('TR')[3].children.children.text
# @trump = doc.search('TR')[4].children.children.text
# @r_rof = doc.search('TR')[5].children.children.text

def get_data
	@republican_candidate = []
	for i in 0..5 do
		cand = Array.new
		for x in 0..6 do
			cand.push(@@doc.search('TR')[i].children.children[x].text)
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
end