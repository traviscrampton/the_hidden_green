class FinanceOption

	ROUTES = {
		'Debts': '/debts',
		'Income': '/incomes',
		'Savings': '/accounts',
		'Investments': '/investments',
		'Monthly Spending': '/monthly_spendings'
	}.with_indifferent_access

	attr_accessor :name, :url

	def initialize(name)
		self.name = name
		self.url = ROUTES[name]
	end
end
