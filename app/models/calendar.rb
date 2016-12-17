class Calendar
	require 'date'
  extend Forwardable

	def_delegators :user, :total_monthly_spending, :total_min_payments, :total_investment

	attr_accessor :user, :accounts, :debts, :investments

	def initialize(options)
		options = options.with_indifferent_access
		self.user = options['user'] if options['user']
	end

	def months_in_year
		["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	end


	def current_date
		return Date::MONTHNAMES[Date.today.month]
	end

	def re_order_year
		current_index = months_in_year.index(current_date) + 1
		pop_months = months_in_year.slice(current_index..11)
		no_pop = months_in_year - pop_months
		return pop_months + no_pop


		# months_in_year.each_with_index do |mon, index|
		# 	binding.pry
		# end

	end


end
