class Debts::PayOffSomeDebtFromSavings

	attr_accessor :month, :savings_objects

	def initialize(month)
		@month = month
		@savings_objects = GetSavingsObjects.new(month).call
	end

	def call
		month.order_debt_by_highest_interest_rate.each do |debt|
			savings_objects.each do |spend|
				if spend.transfer <= debt.amount
					debt.update!(amount: (debt.amount - spend.transfer).round(2))
					month.advices.create(to_type: debt.class, to_id: debt.id, from_type:"Account", from_id: spend.id, amount: spend.transfer)
					spend.transfer = 0
				else
					month.advices.create(to_type:debt.class, to_id: debt.id, from_type:'Account', from_id: spend.id, amount: debt.amount )
					spend.transfer -= debt.amount
					debt.update!(amount: 0)
				end
			end
		end
	end
end
