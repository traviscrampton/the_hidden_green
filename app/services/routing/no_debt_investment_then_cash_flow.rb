class Routing::NoDebtInvestmentThenCashFlow

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.total_savings == month.six_months_spending
			CashFlows::TowardsInvestments.new(month).call
		elsif month.has_investment?
			Investments::SavingsLessTransferInvestment.new(month).call
			Routing::NoDebtInvestmentThenCashFlow.new(month).call
		else
			CashFlows::TowardsSavings.new(month).call
			Routing::SavingsNoDebt.new(month).call if month.cash_flow.amount > 0
		end
	end

end
