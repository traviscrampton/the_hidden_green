class CashFlows::TowardsSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		goal = month.total_debt == 0 ? six_month(month) : three_month(month)
		savings_account = month.order_savings_by_lowest_interest_rate.last
		if goal <= month.cash_flow.amount
			month.advices.create(to_type:savings_account.class, to_id: savings_account.id, from_type: month.cash_flow.class, from_id: month.cash_flow.id, amount: goal)
			savings_account.update!(amount: savings_account.amount + goal)
			month.cash_flow.update!(amount: month.cash_flow.amount - goal)
		else
			month.advices.create(to_type: savings_account.class, to_id:savings_account.id, from_type: month.cash_flow.class, from_id: month.cash_flow.id, amount: month.cash_flow.amount)
			savings_account.update!(amount: savings_account.amount + month.cash_flow.amount)
			month.cash_flow.update!(amount: 0)
		end
	end

	private

	def six_month(month)
		month.six_months_spending - month.total_savings
	end

	def three_month(month)
		month.three_months_spending - month.total_savings
	end
end
