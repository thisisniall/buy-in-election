class HomeController < ApplicationController
  def index
    if current_user
      @candidates = Candidate.all
      @candidate = Candidate.find_by(id: @i)
      @user = current_user
      	# dem is an array of democratic primary results returned from Iowa markets
      	@dem = Iowa::Client.new.dem['results']['collection1']
      	# i stands in for the position in the array
      	@i = 1
      	# dem_array_length is the length of the dem array minus 1
      	@dem_array_length = @dem.length - 1
      	
      	# rep is an array of republican primary results returned from Iowa markets
      	@rep = Iowa::Client.new.rep['results']['collection1']
      	# i stands in for the position in the array
      	@x = 1
      	# dem_array_length is the length of the rep array minus 1
      	@rep_array_length = @rep.length - 1
      	@z = 0
      else
        redirect_to log_in_path
      end

  	# dem_api_url = '9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# rep_api_url = 'bj8hlwos?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# @dem_old_data = Iowa::Client.new.old_data['results']['collection1']
  	# @rep_old_data = Iowa::Client.new.old_data(y, rep_api_url)['results']['collection1']

  	# def list
  	# 	@dem_data = DemData.new('https://iemweb.biz.uiowa.edu/quotes/365.html')
  	# 	@data = @dem_data.get_data(td)
  	# end
  end
end

