class TransactionsController < ApplicationController

#notable variables:
# @user_shares is a variable that will select the appropriate candidate from the users and table and relate them to the correct shares string - on rubio's page, @user_shares will be the user-relationship to rubio
# @user = current user is implicit for this logic to work, else horrible things

	def create
		@transaction = Transaction.new(transaction_params)
		# we use 0 for buy orders and 1 for sell orders, below conditional loop is for buy orders
		# check to make sure user can afford to buy the shares in question!
		if @transaction.type == 0
			# if true approve
			if @user.money >= @transaction.total_value 
				@transaction.save
				@user.money = @user.money - @transaction.total_value 
				@user.@user_shares
				@user.save
			# else dissapprove and alert them to the error
			else

			end
			# for selling, we don't need to make sure the user has the money, we need to make sure they have the shares they want to sell
		elsif @transaction.type == 1
			# if true approve
			if @user.@user_shares > @transaction.shares 
				@transaction.save
				@user.@user_shares = @user.@user_shares - @transaction.shares
				@user.save
			# else disapprove and alert them to the error
			else
			end
		end

	end

end
