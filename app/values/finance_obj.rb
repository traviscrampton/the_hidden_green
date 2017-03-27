class FinanceObj

	attr_accessor :total_amount, :transfer

	def initialize(args)
		self.total_amount = args[:total_amount]
		self.transfer = args[:transfer]
	end
end
