class CashFlows::TowardsSixMonthsSpending

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		goal = month.six_months_spending - month.savings
		savings_account = month.order_savings_by_lowest_interest_rate.last

		if goal <= month.cash_flow.amount
			month.advices.create(description: "Cash flow of #{goal} should go towards your #{savings_account.name} account")
			savings_account.update!(amount: savings_account.amount + goal)
			month.cash_flow.update!(amount: month.cash_flow.amount - goal)
		else
			month.advices.create(description:"Cash flow of #{month.cash_flow.amount} should go towards your #{savings_account.name} account")
			savings_account.update!(amount: savings_account.amount + month.cash_flow.amount)
			month.cash_flow.update!(amount: 0)
		end
	end
end
