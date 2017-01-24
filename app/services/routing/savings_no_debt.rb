class Routing::SavingsNoDebt
	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.total_savings > month.six_months_spending
			Investments::SavingsMoreThanSixMonthsCheckInvestment.new(month).call
			Routing::SavingsNoDebt.new(call)
		else
			Routing::NoDebtInvestmentThenCashFlow.new(month).call
		end
	end
end
