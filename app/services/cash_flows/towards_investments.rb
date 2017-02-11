class CashFlows::TowardsInvestments

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		investment = month.order_investment_by_lowest_rate.last
		month.advices.create(to_type: investment.class, to_id: investment.id, from_type: month.cash_flow.class, from_id: month.cash_flow.id, amount: month.cash_flow.amount)
		investment.update!(amount: investment.amount + month.cash_flow.amount )
		month.cash_flow.update!(amount: 0)
	end
end
