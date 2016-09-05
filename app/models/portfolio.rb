class Portfolio < ActiveRecord::Base
	belongs_to :user
	has_one :monthly_spending
end
