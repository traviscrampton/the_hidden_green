class Saving
	attr_accessor :id, :name, :transfer

	def initialize(args)
		self.id = args[:id]
		self.name = args[:name]
		self.transfer = args[:transfer]
	end
end
