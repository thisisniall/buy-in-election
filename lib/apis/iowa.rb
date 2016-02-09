require 'net/http'
require 'json'

module Iowa
	class Client
		def initialize
			@uri = "https://www.kimonolabs.com/api/"
		end

		def make_request(endpoint)
			JSON.parse(Net::HTTP.get(URI(@uri + endpoint.to_s)))
		end

		def old_data
			@z = 12
			# return make_request(9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'#{z}/#{party_api_url}')
			return make_request('12/9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg')
		end

		def dem
		  return make_request('9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg')
		end

		def rep
		  return make_request('bj8hlwos?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg')
		end

		def average(i)
			thing = dem
			return thing['results']['collection1'][i]['average']
		end
	end
end

# dem = Iowa::Client.new.dem['results']['collection1']
# rep = Iowa::Client.new.rep['results']['collection1']
# clinton = dem[1].values
# sanders = dem[2].values
# 
# [0] = candidate name
# [6] = average
# 
# candidate = Iowa::Client.new
# put candidate.clin => CLIN_NOM
# put candidate.rep