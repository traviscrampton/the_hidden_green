class Debts::ExamineDebt

	attr_accessor :month

	def initialize(month)
		@month = month
	end


	def call
		if month.has_debt?
			Routing::SavingsWithDebt.new(month).call
		else
			Routing::SavingsNoDebt.new(month).call
		end
	end

end
