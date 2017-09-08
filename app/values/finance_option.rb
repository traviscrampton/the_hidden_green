class FinanceOption

	ROUTES = {
		'Debt': '/debts',
		'Income': '/incomes',
		'Account': '/accounts',
		'Investment': '/investments',
		'Monthly Spending': '/monthly_spendings'
	}.with_indifferent_access

	attr_accessor :name, :url

	def initialize(name)
		self.name = name
		self.url = ROUTES[name]
	end
end
