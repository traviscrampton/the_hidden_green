class GetCurrentMonthFinancial

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		{debts: @month.debts, accounts: @month.accounts, investments: @month.investments, incomes: @month.incomes}
	end


end
