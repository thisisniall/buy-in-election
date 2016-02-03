class HomeController < ApplicationController
  def index
  	@candidate = Iowa::Client.new
  end
end
