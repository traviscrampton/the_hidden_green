class Debts::PayOffAllDebtFromSavings

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		month.order_debt_by_highest_interest_rate.each do |debt|
			month.order_savings_by_lowest_interest_rate.each do |saving|
				next if debt.amount == 0 || saving.amount == 0
				if debt.amount <= saving.amount
					saving.update(amount: saving.amount - debt.amount)
					month.advices.create(description: "Transfer #{debt.amount} from your #{saving.name} account to your #{debt.name} debt")
					debt.update!(amount: 0)
				else
					month.advices.create(description:"Transfer #{saving.amount} from your #{saving.name} towards your #{debt.name} debt")
					debt.update(amount: debt.amount - saving.amount )
					saving.update!(amount: 0)
				end
			end
		end
	end
end
