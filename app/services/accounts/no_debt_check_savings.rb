class Accounts::NoDebtCheckSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		binding.pry
		if month.savings < month.six_months_spending
			binding.pry
		else
			Investments::SavingsMoreThanSixMonthsCheckInvestment.new(month).call
		end
	end

end
