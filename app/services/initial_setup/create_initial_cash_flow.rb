class InitialSetup::CreateInitialCashFlow
	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		user.build_cash_flow(amount: user.user_cash_flow).save!
	end
end
