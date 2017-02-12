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
				month.advices.create(to_type:savings_account.class, to_id: savings_account.id, from_type: investment.class, from_id: investment.id, amount: goal)
				savings_account.update!(amount: savings_account.amount + goal)
				investment.update!(amount: investment.amount - goal)
				goal = 0
			else
				month.advices.create(to_type: savings_account.class, to_id: savings_account.id, from_type:investment.class, from_id:investment.id, amount:investment.amount)
				savings_account.update!(amount: savings_account.amount + investment.amount)
				goal = goal - investment.amount
				investment.update!(amount: 0)
			end
		end
	end

	private

	def three_months(month)
		month.three_months_spending - month.total_savings
	end

	def six_months(month)
		month.six_months_spending - month.total_savings
	end
end
