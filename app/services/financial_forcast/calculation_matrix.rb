class FinancialForcast::CalculationMatrix
	attr_accessor :user

	## this month needs to have ability to be any month, and when it's selected that all the months after are affected by this change.

	def initialize(user)
		@user = user
		@remaining_months = GetRemainingMonths.new(user.months.first).call
		@current_financial = GetCurrentMonthFinancial.new(user.months.first).call
		binding.pry
	end

	def call

	end


end



# Goal for this code:
#
# Take the first month and generate it though to calculate an entire
# year but is able to start at the current month that it is taken at and cycle through.
