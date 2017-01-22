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
					debt.update!(amount: debt.amount - spend.transfer)
					month.advices.create(description: "Transfer #{spend.transfer} from your #{spend.name} account to your #{debt.name} debt")
					spend.transfer = 0
				else
					month.advices.create(description: "Transfer #{debt.amount} from your #{spend.name} account to your #{debt.name} debt")
					spend.transfer -= debt.amount
					debt.update!(amount: 0)
				end
			end
		end
	end
end
