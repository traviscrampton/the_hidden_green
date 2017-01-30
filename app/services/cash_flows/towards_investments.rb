class CashFlows::TowardsInvestments

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		investment = month.order_investment_by_lowest_rate.last
		month.advices.create(description: "Cash flow of #{month.cash_flow.amount} should go towards #{investment.name}")
		investment.update!(amount: (investment.amount + month.cash_flow.amount).round(2) )
		month.cash_flow.update!(amount: 0)
	end
end
