class FinancialForcast::CalculationMatrix
	attr_accessor :user

	## this month needs to have ability to be any month, and when it's selected that all the months after are affected by this change.

	def initialize(month)
		@month = month
		@user = month.user
		@remaining_months = GetRemainingMonths.new(@month).call
		@current_financial = GetCurrentMonthFinancial.new(@month).call
	end

	def call
		binding.pry
		Debts::ExamineDebt.new(@month).call
	end


end



# Goal for this code:
#
# Take the first month and generate it though to calculate an entire
# year but is able to start at the current month that it is taken at and cycle through.
