class Routing::SavingsWithDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.total_savings <= month.three_months_spending
			Routing::InvestmentThenCashFlow.new(month).call
		else
			Debts::TransferSavingsToDebt.new(month).call
		end
	end

end
