class FinancialForcast::FutureMonths

	attr_accessor :month, :user

	def initialize(month)
		@month = month
		@user = month.user
	end

	def call
		returned_months(user, month).each do |month|
			FinancialForcast::CalculationMatrix.new(month).call
			FinancialForcast::LoadUpNextMonth.new(month, next_month(user, month)).call unless last_month?(user, month)
		end
	end

	private

	def returned_months(user, month)
		index = user.months.index(month)
		return user.months[index..-1]
	end

	def last_month?(user, month)
		user.months.last == month
	end

	def next_month(user, month)
		index = user.months.index(month)
		return user.months.at(index + 1)
	end

end
