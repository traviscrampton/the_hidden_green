class CreateInitialYearView

	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		created_months = CreateMonths.new(user).call
		created_financials = CreateIndividualMonthFinancials.new(user).call
	end
end
