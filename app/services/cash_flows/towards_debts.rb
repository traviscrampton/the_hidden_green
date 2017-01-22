class CashFlows::TowardsDebts

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		month.order_debt_by_highest_interest_rate.each do |debt|
			next if reasons_to_skip(month.cash_flow.amount, debt)
			if debt.amount <= month.cash_flow.amount
				month.advices.create(description:"Cash flow of #{debt.amount} should go towards #{debt.name} debt")
				month.cash_flow.update!(amount:month.cash_flow.amount - debt.amount)
				debt.update!(amount: 0)
			else
				month.advices.create(description: "Cash flow of #{month.cash_flow.amount} should go towards #{debt.name} debt")
				debt.update!(amount: debt.amount - month.cash_flow.amount )
				month.cash_flow.update!(amount:0 )
			end
		end
	end

	def reasons_to_skip(cash_flow, debt)
		cash_flow == 0 || debt.amount == 0
	end

end
