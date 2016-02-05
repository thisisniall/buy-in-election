class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to '/'
		else
			redirect_to new_user_path
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		@user.save
		redirect_to @user
	end

	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.all
	end

	def destroy
	  	@user = User.find(params[:id])
	    @user.destroy
	    session[:user_id] = nil
	    current_user = nil
	    flash[:notice] = "Account Deleted"
	    redirect_to '/'
	end

	private

	def user_params
    	params.require(:user).permit(:email, :password, :fname, :lname, :party, :money, :shares_clinton, :shares_sanders, :shares_dem_rof, :shares_carson, :shares_cruz, :shares_rubio, :shares_trump, :shares_rep_rof)
  	end

end
