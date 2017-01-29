class InitialSetup::CreateInitialYearView

	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		cash_flow = InitialSetup::CreateInitialCashFlow.new(user).call
		created_months = InitialSetup::CreateMonths.new(user).call
		created_financials = InitialSetup::CreateIndividualMonthFinancials.new(user).call
		FinancialForcast::FutureMonths.new(created_financials).call
	end
end
