class InitialSetup::CreateMonths
	attr_accessor :user

	def initialize(user)
		@user = user
		@twelve_month_scope = InitialSetup::NextTwelveMonthScope.new().call
	end

	def call
		@twelve_month_scope.each { |date|
			 @user.months.find_or_create_by(
				name: date.strftime('%B'),
				sequence_num: date.month,
				year: date.strftime('%Y').to_i
			)
		 }
	end
end
