class FinancialForcast::LoadUpNextMonth

	attr_accessor :month, :next_month, :user

	def initialize(month, next_month)
		@user = month.user
		@month = month
		@next_month = next_month
	end

	def call
		next_month_debts = month.debts.map { |d| next_month.debts.new(
			name: d.name, amount: d.amount, interest_rate: d.interest_rate, minimum_monthly_payment: d.minimum_monthly_payment
			) }

		next_month_accounts = month.accounts.map { |a| next_month.accounts.new(
			a_type: a.a_type, name: a.name, interest_rate: a.interest_rate, amount: a.amount
			)}

		next_month_incomes = user.incomes.map { |i| next_month.incomes.new(
			source_name: i.source_name, source_amount: i.source_amount
		)}

		next_month_investments = month.investments.map { |i| next_month.investments.new(name: i.name, amount: i.amount, interest_rate: i.interest_rate)}

		next_month_monthly_spending = next_month.build_monthly_spending(rent: month.monthly_spending.rent, food: month.monthly_spending.food, phone: month.monthly_spending.phone, utilities: month.monthly_spending.utilities, everything_else: month.monthly_spending.everything_else)

		next_month_cash_flow = next_month.build_cash_flow(amount: user.cash_flow.amount)

		ActiveRecord::Base.transaction do
			begin
				next_month_debts.each(&:save!)
				next_month_accounts.each(&:save!)
				next_month_incomes.each(&:save!)
				next_month_investments.each(&:save!)
				next_month_monthly_spending.save!
				next_month_cash_flow.save!
			rescue ActiveRecord::RecordInvalid => e
			end
		end
	end


end
