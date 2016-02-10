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
      	# dem_array_length is the length of the dem array
      	@dem_array_length = @dem.length

        @clin = @dem[1]['average'].to_f
        @sand = @dem[2]['average'].to_f
        @dem_rof = @dem[3]['average'].to_f
        
        
      	
      	# rep is an array of republican primary results returned from Iowa markets
      	@rep = Iowa::Client.new.rep['results']['collection1']
      	# i stands in for the position in the array
      	@x = 1
      	# dem_array_length is the length of the rep array minus 1
      	@rep_array_length = @rep.length
      	@z = 0

        @car = @rep[1]['average'].to_f
        @cruz = @rep[2]['average'].to_f
        @rub = @rep[3]['average'].to_f
        @trump = @rep[4]['average'].to_f
        @rep_rof = @rep[5]['average'].to_f
      else
        redirect_to log_in_path
      end

  	# dem_api_url = '9wmpnk9k?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# rep_api_url = 'bj8hlwos?apikey=tj1hdT1m9XSPUeh1LyEyBn7Q7mC6qIDg'
  	# @dem_old_data = Iowa::Client.new.old_data['results']['collection1']
  	# @rep_old_data = Iowa::Client.new.old_data(y, rep_api_url)['results']['collection1']

  end
end

