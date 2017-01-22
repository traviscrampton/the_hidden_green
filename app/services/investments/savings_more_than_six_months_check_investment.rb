class Investments::SavingsMoreThanSixMonthsCheckInvestment

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		## Need to figure out if people have 2 savings accounts. For this purpse is anybody actually going to do that?

		transfer = (month.six_months_spending - month.savings).abs
		top_investment = if month.investments.any?
			month.investments.order("interest_rate DESC").first
		else
			month.investments.create(name:'S&P', interest_rate: 0.07, amount:0.0)
		end
		month.advices.new(description:"Transfer #{transfer} from your #{month.accounts.find_by(a_type:'savings').name} account into your #{top_investment.name } investment")

		month.accounts.find_by(a_type:'savings').update(amount: month.six_months_spending)

		top_investment.update(amount: top_investment.amount += transfer)
		#TODO: This is where you are leaving out. If all is good then you will start handling cash flow at this point!

	end




	# def savings_more_than_6_months_check_investments(debt, savings, total_investment, cash_flow, advice)
	# 	transfer = savings - user.six_months_spending
	# 	total_investment[:amount] += transfer
	# 	savings = user.six_months_spending
	# 	advice.push("Move #{transfer} from your savings into your investments") unless transfer == 0
	# 	cash_flow_to_investment(debt, savings, total_investment, cash_flow, advice)
	# end
end
