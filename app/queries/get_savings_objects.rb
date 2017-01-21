class GetSavingsObjects
	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
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
