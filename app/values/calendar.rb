class Calendar

	attr_accessor :user, :months

	def initialize(user)
		self.months = options(user)
	end

	private

	def options(user)
		user.hashitize_months
	end

end
