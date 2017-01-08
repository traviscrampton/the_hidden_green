class NextTwelveMonthScope


	def initialize
	end

	def call
		month_array = [Time.now]
		twelve_months =
		12.times {
			time = month_array.last
			month_array.push(time += 1.month)
		}
		month_array.map { |d| d }
	end
end
