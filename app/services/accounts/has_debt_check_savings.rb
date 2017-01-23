class Accounts::HasDebtCheckSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end


	def call
		if month.savings < month.three_months_spending
			Investments::SavingsLessThreeMonthsCheckInvestments.new(month).call if month.total_investment > 0
		else
			Debts::TransferSavingsToDebt.new(month).call
		end
	end

end
