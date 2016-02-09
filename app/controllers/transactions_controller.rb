class TransactionsController < ApplicationController
#notable variables:
# share_type_selection_method is a variable that will select the appropriate candidate from the users and table and relate them to the correct shares string - on rubio's page, share_type_selection_method will be the user-relationship to rubio
# buysell 0 is buy, buysell 1 is sell
# @user = current user is implicit for this logic to work, else horrible things
	def new
		@user = current_user
		@transaction = Transaction.new
				@candidates = Candidate.all
	end

	def index
		@user = current_user
		@transactions = Transaction.all
		@candidates = Candidate.all
		@transaction = Transaction.new

		# dem and rep are methods defined in lib/apis/iowa.rb
		@dem = Iowa::Client.new.dem['results']['collection1']
		@rep = Iowa::Client.new.rep['results']['collection1']
	end
	
	def create
		@user = current_user
		@candidates = Candidate.all
		@transaction = Transaction.new(transaction_params)

		def share_type_selection_method
			if @transaction.shares_clinton != nil 
				@candidate = Candidate.find_by(name: "Hillary Clinton")
				return 'shares_clinton'			
			elsif @transaction.shares_sanders != nil
				@candidate = Candidate.find_by(name: "Bernie Sanders")
				return 'shares_sanders'	
			elsif @transaction.shares_dem_rof != nil
				@candidate = Candidate.find_by(name: "Democratic Rest of Field")
				return 'shares_dem_rof'
			elsif @transaction.shares_carson != nil
				@candidate = Candidate.find_by(name: "Ben Carson")
				return 'shares_carson]'
			elsif @transaction.shares_cruz != nil
				@candidate = Candidate.find_by(name: "Ted Cruz")
				return 'shares_cruz'
			elsif @transaction.shares_rubio != nil
				@candidate = Candidate.find_by(name: "Marco Rubio")
				return 'shares_rubio'	
			elsif @transaction.shares_trump != nil
				@candidate = Candidate.find_by(name: "Donald Trump")
				return'shares_trump'
			elsif @transaction.shares_rep_rof != nil
				@candidate = Candidate.find_by(name: "Republican Rest of Field")
				return'shares_rep_rof'
			end
			# return share_type_selection_method
		end

		# we use 0 for buy orders and 1 for sell orders, below conditional loop is for buy orders
		# check to make sure user can afford to buy the shares in question!	
		@transaction.total_value = BigDecimal(params[:transaction][:price]) * (params[:transaction][share_type_selection_method].to_i)			
		if @transaction.buysell == 0
			# if true approve
			if @user.money >= @transaction.total_value 
				@transaction.save
				# updates user money and share counts
				@user.money = @user.money - @transaction.total_value 
				@user[share_type_selection_method] = @user[share_type_selection_method] + @transaction[share_type_selection_method]
				@user.save
				# update candidate share counts
				puts @candidate
				puts @candidate.total_shares
				puts @transaction[share_type_selection_method]
				@candidate.total_shares = @candidate.total_shares + @transaction[share_type_selection_method]
				@candidate.iowa_value = @transaction.price
				@candidate.save
			# else dissapprove and alert them to the error
			else
				flash[:alert] = "You do not have enough money to pay for this transaction."
			end
			# for selling, we don't need to make sure the user has the money, we need to make sure they have the shares they want to sell
		elsif @transaction.buysell == 1
			# if true approve
			if @user[share_type_selection_method] >= @transaction[share_type_selection_method]
				@transaction.save
				# updates user money and share counts
				@user.money = @user.money + @transaction.total_value 
				@user[share_type_selection_method] = @user[share_type_selection_method] - @transaction[share_type_selection_method]
				@user.save
				# update candidate share counts, price, money
				@candidate.total_shares = @candidate.total_shares - @transaction[share_type_selection_method]
				@candidate.iowa_value = @transaction.price
				@candidate.save
			# else disapprove and alert them to the error
			else
				flash[:alert] = "You do not have enough shares to sell!"
			end
		end
		redirect_to user_path(@user)
	end

	def price_check
		@user = current_user
		@transaction = Transaction.new

	end

	private

	def transaction_params
		params.require(:transaction).permit(:user_id, :candidate_id, :price, :buysell, :total_value, :shares_clinton, :shares_sanders, :shares_dem_rof, :shares_carson, :shares_cruz, :shares_rubio, :shares_trump, :shares_rep_rof)
	end
end

