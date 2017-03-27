class SingleMonth

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		single_month = month.attributes
		single_month['debts'] = month.debts.map do |debt|
			debt.attributes
		end
		single_month['investments'] = month.investments.map do |investment|
			investment.attributes
		end
		single_month['incomes'] = month.incomes.map do |income|
			income.attributes
		end
		single_month['accounts'] = month.accounts.map do |account|
			account.attributes
		end
		single_month['monthly_spending'] = month.monthly_spending.attributes
		compile_advice(single_month)
	end

	def compile_advice(single_month)
		single_month['advices'] = month.advices.map do |advice|
			from = "Transfer " + advice.amount.to_s + " from your " + advice.from_what
			to = "to your " + advice.to.name + " " + advice.to.class.to_s
			from + to
		end
		single_month
	end
end
