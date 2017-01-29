class Calendar::Month

	attr_accessor :month, :debts, :accounts, :investments, :cash_flows, :monthly_spending, :incomes, :advices

	def initialize(options)
		self.debts = options['debts']
		self.accounts = options['accounts']
		self.investments = options['investments']
		self.incomes = options['incomes']
		self.cash_flow = options['cash_flow']
		self.advices = options['advices']
		self.monthly_spending = options['monthly_spending']
	end

	# def call
	# 	options = {}
	# 	options['debts'] = month.debts
	# 	options['incomes'] = month.incomes
	# 	options['accounts'] = month.accounts
	# 	options['monthly_spending'] = month.monthly_spending
	# 	options['investments'] = month.investments
	# 	options['cash_flow'] = month.cash_flow
	# 	options['advices'] = month.advices
	# end




end
