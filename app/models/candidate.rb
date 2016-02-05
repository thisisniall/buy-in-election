class Candidate < ActiveRecord::Base
	has_many :transactions
end
