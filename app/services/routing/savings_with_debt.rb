class Routing::SavingsWithDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.total_savings <= month.three_months_spending
			Routing::DebtInvestmentThenCashFlow.new(month).call
		else
			Debts::TransferSavingsToDebt.new(month).call
			Debts::ExamineDebt.new(month).call
		end
	end

end
