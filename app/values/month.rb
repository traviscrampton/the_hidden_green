class IndividualMonth

	attr_accessor :month, :debts, :accounts, :investments, :cash_flows, :monthly_spending, :incomes, :advices

	def initialize(month)
		@month = month
	end

	def call
		self.debts = month.debts
		self.incomes = month.incomes
		self.accounts = month.accounts
		self.monthly_spending = month.monthly_spending
		self.investments = month.investments
		self.cash_flow = month.cash_flow
		self.advices = month.advices
	end




end
