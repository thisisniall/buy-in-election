class TransactionsController < ApplicationController

#notable variables:
# share_type_selection_method is a variable that will select the appropriate candidate from the users and table and relate them to the correct shares string - on rubio's page, share_type_selection_method will be the user-relationship to rubio
# type 0 is buy, type 1 is sell
# @user = current user is implicit for this logic to work, else horrible things
	def new
		@transaction = Transaction.new
	end

	def _buy
		@transaction = Transaction.new(transaction_params)
		type = 0
	end

	def _sell
		@transaction = Transaction.new(transaction_params)
		type = 1
	end

	def index
		@transactions = Transaction.all

	end
​
	def create
		@transaction = Transaction.new(transaction_params)
​
		if @transaction.param[:shares_clinton] != nil
			share_type_selection_method = 'shares_clinton'
			@candidate = Candidate.find_by(name: "Hillary Clinton")
		elsif @transaction.param[:shares_sanders] != nil
			share_type_selection_method = 'shares_sanders'
			@candidate = Candidate.find_by(name: "Bernie Sanders")
		elsif @transaction.param[:shares_dem_rof] != nil
			share_type_selection_method = 'shares_dem_rof'
			@candidate = Candidate.find_by(name: "Democratic Rest of Field")
		elsif @transaction.param[:shares_carson] != nil
			share_type_selection_method = 'shares_carson]'
			@candidate = Candidate.find_by(name: "Ben Carson")	 
		elsif @transaction.param[:shares_cruz] != nil
			share_type_selection_method = 'shares_cruz'
			@candidate = Candidate.find_by(name: "Ted Cruz")	
		elsif @transaction.param[:shares_rubio] != nil
			share_type_selection_method = 'shares_rubio'
			@candidate = Candidate.find_by(name: "Marco Rubio")	
		elsif @transaction.param[:shares_trump] != nil
			share_type_selection_method = 'shares_trump'
			@candidate = Candidate.find_by(name: "Donald Trump")
		elsif @transaction.param[:shares_rep_rof] != nil
			share_type_selection_method = 'shares_rep_rof'
			@candidate = Candidate.find_by(name: "Republican Rest of Field")
		end
​
		# we use 0 for buy orders and 1 for sell orders, below conditional loop is for buy orders
		# check to make sure user can afford to buy the shares in question!					
		if @transaction.type == 0
			# if true approve
			if @user.money >= @transaction.total_value 
				@transaction.save
				# updates user money and share counts
				@user.money = @user.money - @transaction.total_value 
				@user.share_type_selection_method = @user.share_type_selection_method + transaction.share_type_selection_method
				@user.save
				# update candidate share counts

			# else dissapprove and alert them to the error
			else
​				flash[:alert] = "You do not have enough money to pay for this transaction."
			end
			# for selling, we don't need to make sure the user has the money, we need to make sure they have the shares they want to sell
		elsif @transaction.type == 1
			# if true approve
			if @user.share_type_selection_method > @transaction.shares 
				@transaction.save
				# updates user money and share counts
				@user.money = @user.money + @transaction.total_value 
				@user.share_type_selection_method = @user.share_type_selection_method - @transaction.share_type_selection_method
				@user.save
				# update candidate share counts
			# else disapprove and alert them to the error
			else
				flash[:alert] = "You do not have enough shares to sell!"
			end
		end
​
	end
​
end

