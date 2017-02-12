class Investments::SavingsMoreThanSixMonthsCheckInvestment

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		investment = month.order_investment_by_lowest_rate.last
		difference = month.total_savings - month.six_months_spending

		month.order_savings_by_lowest_interest_rate.each do |savings|
			next if reason_to_skip(difference, savings)
			if difference <= savings.amount
				month.advices.create(to_type: investment.class, to_id: investment.id, from_type:savings.class, from_id:savings.id, amount: difference)
				savings.update!(amount: savings.amount - difference )
				investment.update!(amount: investment.amount + difference)
				difference = 0
			else
				month.advices.create(to_type:investment.class, to_id: investment.id, from_type:savings.class, from_id: savings.id, amount: savings.amount)
				difference -= savings.amount
				investment.update!(amount: investment.amount + savings.amount)
				savings.update!(amount: 0)
			end
		end
	end

	def reason_to_skip(difference, savings)
		difference == 0 || savings.amount == 0
	end

end
