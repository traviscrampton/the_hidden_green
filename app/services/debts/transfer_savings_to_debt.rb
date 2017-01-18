class Debts::TransferSavingsToDebt

	attr_accessor :month

	def initialize(month)
		@month = month
		@immediate_transfer = month.savings - month.three_months_spending
	end

	def call
		if month.total_debt >= @immediate_transfer
			binding.pry
		else
			Debts::PayOffAllDebtFromSavings.new(@month).call
		end
	end

end
