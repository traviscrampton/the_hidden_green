class InitialSetup::CreateIndividualMonthFinancials

	attr_accessor :user

	def initialize(user)
		@user = user
	end

	def call
		first_month = user.months.first
		first_month_debts = user.debts.map { |d| first_month.debts.new(
			name: d.name, amount: d.amount, interest_rate: d.interest_rate, minimum_monthly_payment: d.minimum_monthly_payment
			) }

		first_month_accounts = user.accounts.map { |a| first_month.accounts.new(
			a_type: a.a_type, name: a.name, interest_rate: a.interest_rate, amount: a.amount
			)}

		first_month_incomes = user.incomes.map { |i| first_month.incomes.new(
			source_name: i.source_name, source_amount: i.source_amount
			)}

		first_month_investments = user.investments.map { |i| first_month.investments.new(name: i.name, amount: i.amount, interest_rate: i.interest_rate)}

		first_month_monthly_spending = first_month.build_monthly_spending(rent: user.monthly_spending.rent, food: user.monthly_spending.food, phone: user.monthly_spending.phone, utilities: user.monthly_spending.utilities, everything_else: user.monthly_spending.everything_else)
		first_month_cash_flow = first_month.build_cash_flow(amount: user.cash_flow.amount)

		ActiveRecord::Base.transaction do
			begin
				first_month_debts.each(&:save!)
				first_month_accounts.each(&:save!)
				first_month_incomes.each(&:save!)
				first_month_investments.each(&:save!)
				first_month_monthly_spending.save!
				first_month_cash_flow.save!
			rescue ActiveRecord::RecordInvalid => e

			end
		end


	end
end
