class Debts::ExamineDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end


	def call
		if month.has_debt?
			if month.total_savings < month.three_months_spending

		# if month.total_debt > 0
		# 	Accounts::HasDebtCheckSavings.new(month).call
		# else
		# 	return
		# end
	end

end
