require 'net/http'
require 'json'

module Iowa
	class Client

		def initialize
			@uri = 'https://www.kimonolabs.com/api/'
		end

		def make_request(endpoint)
			JSON.parse(Net::HTTP.get(URI(@uri + endpoint.to_s)))
		end

		def dem
		  return make_request('9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg')
		end

		def rep
		  return make_request('bj8hlwos?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg')
		end

		def clin
			thing = dem
			return thing['results']['collection1'][1]['candidate']
		end

		def sand
			thing = dem
			return thing['results']['collection1'][2]['candidate']
		end
		
	end
end



# candidate = Iowa::Client.new
# put candidate.clin => CLIN_NOM
# put candidate.rep