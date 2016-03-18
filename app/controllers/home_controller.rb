class HomeController < ApplicationController
  def index
    if current_user
      @candidates = Candidate.all
      @candidate = Candidate.find_by(id: @i)
      @user = current_user
      	# dem is an array of democratic primary results returned from Iowa markets
      	# @dem = Iowa::Client.new.dem['results']['collection1']
        @dem = Candidate.d_get_data
      	# i stands in for the position in the array
      	@i = 0
      	# dem_array_length is the length of the dem array
      	@dem_array_length = @dem.length

        # need to define these for the data array used in the graphs
        @clin = @dem[0]['Average'].to_f
        @sand = @dem[1]['Average'].to_f
        @dem_rof = @dem[2]['Average'].to_f

        # need to define these for the backup data array used in the graphs
        @clinL = @dem[0]['Last'].to_f
        @sandL = @dem[1]['Last'].to_f
        @dem_rofL = @dem[2]['Last'].to_f
        
      	
      	# rep is an array of republican primary results returned from Iowa markets
      	@rep = Candidate.r_get_data
      	# x stands in for the position in the array
      	@x = 0
      	# dem_array_lsength is the length of the rep array minus 1
      	@rep_array_length = @rep.length
      	@z = 0

        @car = @rep[0]['Average'].to_f
        @cruz = @rep[1]['Average'].to_f
        @rub = @rep[2]['Average'].to_f
        @trump = @rep[3]['Average'].to_f
        @rep_rof = @rep[4]['Average'].to_f

        @carL = @rep[0]['Last'].to_f
        @cruzL = @rep[1]['Last'].to_f
        @rubL = @rep[2]['Last'].to_f
        @trumpL = @rep[3]['Last'].to_f
        @rep_rofL = @rep[4]['Last'].to_f
      else
        redirect_to log_in_path
      end

  	# dem_api_url = '9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# rep_api_url = 'bj8hlwos?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# @dem_old_data = Iowa::Client.new.old_data['results']['collection1']
  	# @rep_old_data = Iowa::Client.new.old_data(y, rep_api_url)['results']['collection1']

  end
end

