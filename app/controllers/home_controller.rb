class HomeController < ApplicationController
  def index
  	# dem is an array of democratic primary results returned from Iowa markets
  	@dem = Iowa::Client.new.dem['results']['collection1']
  	@i = 1
  	@d = @dem.length - 1
  	
  	# rep is an array of republican primary results returned from Iowa markets
  	@rep = Iowa::Client.new.rep['results']['collection1']
  	@x = 1
  	@r = @rep.length - 1

  end
end
