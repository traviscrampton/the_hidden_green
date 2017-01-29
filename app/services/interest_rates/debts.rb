class InterestRates::Debts

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		return if !month.has_debt?
		month.debts.reload
		month.debts.each do |debt|
			compounding_interest_rate(debt)
		end
	end


	private

	# is reasonable creditcard debt actually nailin pailin?

	def compounding_interest_rate(debt)
		percentage = (debt.interest_rate/12)
		interest = (debt.amount*percentage).round(2)
		debt.update!(amount: debt.amount + interest)
	end
end
