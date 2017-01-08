class MonthlySpending < ActiveRecord::Base
	belongs_to :monthly_spendable, polymorphic: true
end
