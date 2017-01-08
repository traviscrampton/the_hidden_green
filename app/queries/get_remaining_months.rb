class GetRemainingMonths

	def initialize(month)
		@month = month
		@user = @month.user
	end

	def call
		next_month = @user.months.index(@month) + 1
		@user.months[next_month..-1]
	end
end
