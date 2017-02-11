class CashFlows::TowardsDebts

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		month.order_debt_by_highest_interest_rate.each do |debt|
			next if reasons_to_skip(month.cash_flow.amount, debt)
			if debt.amount <= month.cash_flow.amount
				month.advices.create(to_type: debt.class, to_id: debt.id, from_type: month.cash_flow.class, from_id: month.cash_flow.id, amount: debt.amount)
				month.cash_flow.update!(amount:month.cash_flow.amount - debt.amount)
				debt.update!(amount: 0)
			else
				month.advices.create(to_type: debt.class, to_id: debt.id, from_id: month.cash_flow.id, from_type: month.cash_flow.class, amount: month.cash_flow.amount)
				debt.update!(amount:debt.amount - month.cash_flow.amount )
				month.cash_flow.update!(amount:0 )
			end
		end
	end

	def reasons_to_skip(cash_flow, debt)
		cash_flow == 0 || debt.amount == 0
	end

end
