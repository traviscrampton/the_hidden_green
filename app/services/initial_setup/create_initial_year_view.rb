class InitialSetup::CreateInitialYearView

	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		created_months = InitialSetup::CreateMonths.new(user).call
		created_financials = InitialSetup::CreateIndividualMonthFinancials.new(user).call
	end
end
