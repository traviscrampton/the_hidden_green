class CashFlows::TowardsSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		goal = month.total_debt == 0 ? six_month(month) : three_month(month)

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

	private

	def six_month(month)
		month.six_months_spending - month.total_savings
	end

	def three_month(month)
		month.three_months_spending - month.total_savings
	end
end
