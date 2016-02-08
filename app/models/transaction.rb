class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :candidate

# hashed out these validations for testing purposes
	# validates_presence_of :user, on: :create
	# validates_presence_of :candidate, on: :create
end