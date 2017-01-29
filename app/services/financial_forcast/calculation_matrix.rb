class FinancialForcast::CalculationMatrix
	attr_accessor :month

	## this month needs to have ability to be any month, and when it's selected that all the months after are affected by this change.

	def initialize(month)
		@month = month
	end

	def call
		Debts::PayMinimumPayment.new(month).call
		Debts::ExamineDebt.new(month).call
		InterestRates::Debts.new(month).call
	end

end

# main goal here is to be able to have this be about as decoupled as possible with a calculation matrix being the one handling the different stages so not every function is handling the next action
