class CreateInitialYearView

	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		# service job to create all the months in the correct year
		created_months = CreateMonths.new(user).call
		#
		# makes sure that when the year gets to 12 to stop creating shit
		#
	end
end
