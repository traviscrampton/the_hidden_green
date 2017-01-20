class Debts::PayOffSomeDebtFromSavings

	####
	# This might turn into just transfering objects over to be thrown into the other function
	####
	####




	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		spendable = get_savings_objects
		month.order_debt_by_highest_interest_rate.each do |debt|
			spendable.each do |spend|
				if spend.transfer <= debt.amount
					debt.update!(amount: debt.amount - spend.transfer)
					month.advices.new(description: "Transfer #{spend.transfer} from your #{spend.name} account to your #{debt.name} debt").save!
					spend.transfer = 0
				else
					month.advices.new(description: "Transfer #{debt.amount} from your #{spend.name} account to your #{debt.name} debt")
					spend.transfer -= debt.amount
					debt.update!(amount: 0)
				end
			end
		end
	end

	private

	def reason_to_skip(debt, saving, spendable)
		month.savings < month.three_months_spending || debt.amount == 0 || saving.amount == 0 || spendable == 0
	end

	def get_savings_objects
		spendable_amount = month.savings - month.three_months_spending
		month.order_savings_by_lowest_interest_rate.map do |saving|
			next if spendable_amount == 0
			if saving.amount <= spendable_amount
				account = Saving.new({name: saving.name, transfer: saving.amount })
				spendable_amount -= saving.amount
				saving.update(amount: 0)
			else
				account = Saving.new({name:saving.name, transfer: spendable_amount })
				saving.update(amount: saving.amount - spendable_amount)
				spendable_amount = 0
			end
			account
		end
	end
end
