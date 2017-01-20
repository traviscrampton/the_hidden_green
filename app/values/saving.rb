class Saving
	attr_accessor :name, :transfer

	def initialize(args)
		self.name = args[:name]
		self.transfer = args[:transfer]
	end
end
