class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.where(username: params[:username]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "You've been signed in!"
			redirect_to '/'
		else
			flash[:alert] = "Username and password do not match our records."
			redirect_to log_in_path
		end
	end

	def destroy
		session[:user_id] = nil
		current_user = nil
		flash[:notice] = "You've logged out."
		redirect_to log_in_path
	end

	def time_ago_in_words(from_time)
    	distance_of_time_in_words(from_time, Time.now)
  	end
  	
end
