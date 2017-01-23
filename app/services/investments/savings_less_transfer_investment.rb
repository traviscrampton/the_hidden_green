class Investments::SavingsLessTransferInvestment

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		goal = month.has_debt? ? three_months(month) : six_months(month)
		savings_account = month.order_savings_by_lowest_interest_rate.last
		month.order_investment_by_lowest_rate.each do |investment|
			next if goal == 0
			if goal <= investment.amount
				month.advices.create(description:"Transfer #{goal} from your #{investment.name} investment to your #{savings_account.name} account")
				savings_account.update!(amount: savings_account.amount + goal)
				investment.update!(amount: investment.amount - goal)
				goal = 0
			else
				month.advices.create(description:"Transfer #{investment.amount} from your #{investment.name} investment to your #{savings_account.name} account")
				savings_account.update!(amount: savings_account.amount + investment.amount)
				goal = goal - investment.amount
				investment.update!(amount: 0)
			end
		end
	end

	private

	def three_months(month)
		month.three_months_spending - month.savings
	end

	def six_months(month)
		month.six_months_spending - month.savings
	end
end
