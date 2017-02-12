class Investments::TransferInvestmentToDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		month.order_debt_by_highest_interest_rate.each do |debt|
			month.order_investment_by_lowest_rate.each do |investment|
				next if reason_to_skip(investment, debt)
				if debt.amount <= investment.amount
					month.advices.create(to_type:debt.class, to_id:debt.id, from_type: investment.class, from_id:investment.id, amount: debt.amount)
					investment.update!(amount: investment.amount - debt.amount)
					debt.update!(amount: 0)
				else
					month.advices.create(to_type:debt.class, to_id: debt.id, from_type:investment.class, from_id: investment.id, amount: investment.amount)
					debt.update!(amount: debt.amount - investment.amount)
					investment.update!(amount: 0)
				end
			end
		end
	end

	def reason_to_skip(investment, debt)
		investment.amount == 0 || debt.amount == 0
	end
end
