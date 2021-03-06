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
					saving.update(amount: (saving.amount - debt.amount).round(2))
					month.advices.create(from_type:saving.class, from_id: saving.id, to_type: debt.class, to_id: debt.id, amount: debt.amount)
					debt.update!(amount: 0)
				else
					month.advices.create(from_type: saving.class, from_id:saving.id, to_type:debt.class, to_id:debt.id, amount: saving.amount)
					debt.update(amount: (debt.amount - saving.amount).round(2) )
					saving.update!(amount: 0)
				end
			end
		end
	end
end
