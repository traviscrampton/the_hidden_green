class Accounts::NoDebtCheckSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.total_savings < month.six_months_spending
			CashFlows::TowardsSixMonthsSpending.new(month).call
		else
			Investments::SavingsMoreThanSixMonthsCheckInvestment.new(month).call
		end
	end

end
