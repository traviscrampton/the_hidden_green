class MonthObj

	attr_accessor :month, :debts, :accounts, :investments, :cash_flow, :monthly_spending, :incomes, :advices

	def initialize(options)
		self.month = options['month']
		self.debts = options['debts']
		self.accounts = options['accounts']
		self.investments = options['investments']
		self.incomes = options['incomes']
		self.cash_flow = options['cash_flow']
		self.advices = options['advices']
		self.monthly_spending = options['monthly_spending']
	end

end
