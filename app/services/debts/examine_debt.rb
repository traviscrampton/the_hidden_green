class Debts::ExamineDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end


	def call
		if month.total_debt > 0
			Accounts::HasDebtCheckSavings.new(month).call
		else
			binding.pry
			Accounts::NoDebtCheckSavings.new(month).call
		end
	end

end
