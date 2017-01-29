class Debts::PayMinimumPayment

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		return if !month.has_debt?
		month.debts.each do |debt|
			if debt.amount >= debt.minimum_monthly_payment
				debt.update!(amount: debt.amount - debt.minimum_monthly_payment)
				month.cash_flow.update!(amount: month.cash_flow.amount - debt.minimum_monthly_payment)
			else
				transaction = debt.minimum_monthly_payment - debt.amount
				debt.update!(amount: 0)
				month.cash_flow.update!(amount: month.cash_flow.amount - transaction)
			end
		end
	end
end
