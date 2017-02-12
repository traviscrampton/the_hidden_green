class InterestRates::Debts

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		month.debts.reload
		return if !month.has_debt?
		month.debts.each do |debt|
			compounding_interest_rate(debt)
		end
	end


	private

	# should there be a boolean on whether or not

	def compounding_interest_rate(debt)
		percentage = (debt.interest_rate/12)
		interest = (debt.amount*percentage)
		debt.update!(amount: (debt.amount + interest).round(2))
	end
end
