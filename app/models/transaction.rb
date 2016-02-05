class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :candidate

	validates_presence_of :user, on: :create
	validates_presence_of :candidate, on: :create
end
