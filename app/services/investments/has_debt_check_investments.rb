class Investments::HasDebtCheckInvestments

	attr_accessor :month

	def initialize(month)
		@month = month
	end

	def call
		return if month.total_investment == 0
		Investment::TransferInvestmentToDebt.new(month).call
	end

end
