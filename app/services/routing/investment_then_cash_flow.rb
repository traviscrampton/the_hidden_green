class Routing::InvestmentThenCashFlow

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		if month.has_investment?
			investment_where(month)
		elsif month.has_cash_flow?
			cash_flow_where(month)
		else
			return
		end
	end

	private

	def investment_where(month)
		if month.total_savings == month.three_months_spending
			Investments::TransferInvestmentToDebt.new(month).call
		else
			Investments::SavingsLessTransferInvestment.new(month).call
		end
		Debts::ExamineDebt.new(month).call
	end

	def cash_flow_where(month)
		if month.total_savings == month.three_months_spending
			CashFlows::TowardsDebts.new(month).call
		else
			CashFlows::TowardsSavings.new(month).call
		end
		Debts::ExamineDebt.new(month).call
	end

end
