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
		# dem is an array of democratic primary results returned from Iowa markets
      	@dem = Dem::Client.new.get_data
      	# i stands in for the position in the array
      	@i = 0
      	# dem_array_length is the length of the dem array minus 1
      	@dem_array_length = @dem.length - 1
      	
      	# rep is an array of republican primary results returned from Iowa markets
      	@rep = Rep::Client.new.get_data
      	# i stands in for the position in the array
      	@x = 0
      	# dem_array_length is the length of the rep array minus 1
      	@rep_array_length = @rep.length - 1
      	@z = 0
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		@user.save
		redirect_to @user
	end

	def show
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to root_path
		end
		@candidates = Candidate.all
		@clin = @user.shares_clinton
		@sand = @user.shares_sanders
		@dem_rof = @user.shares_dem_rof
		@car = @user.shares_carson
		@cruz = @user.shares_cruz
		@rub = @user.shares_rubio
		@trump = @user.shares_trump
		@rep_rof = @user.shares_rep_rof
		@dataArray = [@clin, @sand, @dem_rof, @car, @cruz, @rub, @trump, @rep_rof].max
		# @max = @dataArray.max
	
		# dem is an array of democratic primary results returned from Iowa markets
      	@dem = Dem::Client.new.get_data
      	# i stands in for the position in the array
      	@i = 0
      	# dem_array_length is the length of the dem array
      	@dem_array_length = @dem.length - 1

        # need to define these for the data array used in the graphs
        @clinA = @dem[0]['Average'].to_f
        @sandA = @dem[1]['Average'].to_f
        @dem_rofA = @dem[2]['Average'].to_f

        # need to define these for the backup data array used in the graphs
        @clinL = @dem[0]['Last'].to_f
        @sandL = @dem[1]['Last'].to_f
        @dem_rofL = @dem[2]['Last'].to_f
        
      	
      	# rep is an array of republican primary results returned from Iowa markets
      	@rep = Rep::Client.new.get_data
      	# i stands in for the position in the array
      	@x = 0
      	# dem_array_length is the length of the rep array minus 1
      	@rep_array_length = @rep.length - 1
      	@z = 1

        @carA = @rep[0]['Average'].to_f
        @cruzA = @rep[1]['Average'].to_f
        @rubA = @rep[2]['Average'].to_f
        @trumpA = @rep[3]['Average'].to_f
        @rep_rofA = @rep[4]['Average'].to_f

        @carL = @rep[0]['Last'].to_f
        @cruzL = @rep[1]['Last'].to_f
        @rubL = @rep[2]['Last'].to_f
        @trumpL = @rep[3]['Last'].to_f
        @rep_rofL = @rep[4]['Last'].to_f
	end

	def index
		@users = User.all
	end

	def _edit
		@user = current_user
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
