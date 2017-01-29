class Calendar

	attr_accessor :user, :months

	def initialize(user)
		@user = user
		@months = user.months.map { |m| IndividualMonth.new(m).call }
	end

	def call
		self.months = months
	end


end
