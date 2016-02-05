class TransactionsController < ApplicationController

#notable variables:
# share_type_selection_method is a variable that will select the appropriate candidate from the users and table and relate them to the correct shares string - on rubio's page, share_type_selection_method will be the user-relationship to rubio
# @user = current user is implicit for this logic to work, else horrible things
​
	def create
		@transaction = Transaction.new(transaction_params)
​
		if @transaction.param[:shares_clinton] != nil
			share_type_selection_method = 'shares_clinton'
		elsif @transaction.param[:shares_sanders] != nil
			share_type_selection_method = 'shares_sanders'
		elsif @transaction.param[:shares_dem_rof] != nil
			share_type_selection_method = 'shares_dem_rof'
		elsif @transaction.param[:shares_carson] != nil
			share_type_selection_method = 'shares_carson]' 
		elsif @transaction.param[:shares_cruz] != nil
			share_type_selection_method = 'shares_cruz'
		elsif @transaction.param[:shares_rubio] != nil
			share_type_selection_method = 'shares_rubio'					
		elsif @transaction.param[:shares_trump] != nil
			share_type_selection_method = 'shares_trump'
		elsif @transaction.param[:shares_rep_rof] != nil
			share_type_selection_method = 'shares_rep_rof'
		end
​
		# we use 0 for buy orders and 1 for sell orders, below conditional loop is for buy orders
		# check to make sure user can afford to buy the shares in question!					
		if @transaction.type == 0
			# if true approve
			if @user.money >= @transaction.total_value 
				@transaction.save
				@user.money = @user.money - @transaction.total_value 
				@user.share_type_selection_method = @user.share_type_selection_method + transaction.share_type_selection_method
				@user.save
			# else dissapprove and alert them to the error
			else
​
			end
			# for selling, we don't need to make sure the user has the money, we need to make sure they have the shares they want to sell
		elsif @transaction.type == 1
			# if true approve
			if @user.share_type_selection_method > @transaction.shares 
				@transaction.save
				@user.money = @user.money + @transaction.total_value 
				@user.share_type_selection_method = @user.share_type_selection_method - @transaction.share_type_selection_method
				@user.save
			# else disapprove and alert them to the error
			else
			end
		end
​
	end
​
end


