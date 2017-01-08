class Month < ActiveRecord::Base

	belongs_to :user
	has_one :monthly_spending, as: :monthly_spendable
	has_many :debts, as: :debtable, dependent: :destroy
	has_many :accounts, as: :accountable, dependent: :destroy
	has_many :incomes, as: :incomeable, dependent: :destroy
	has_many :debts, as: :debtable, dependent: :destroy
	has_many :investments, as: :investmentable, dependent: :destroy

	def total_monthly_spending
		values = monthly_spending.attributes.except("id", "user_id").values
		values.reduce(:+)
  end

  def total_debt
		debts.any? ? debts.pluck(:amount).reduce(:+) : 0
  end

  def total_min_monthly_payments
		debts.any? ? debts.pluck(:minimum_monthly_payment).reduce(:+) : 0
  end

  def total_investment
		investments.any? ? add_and_average_investments : create_psuedo_investment
  end

	def add_and_average_investments
		total_amount = investments.pluck(:amount).reduce(:+)
		average_interest_rate = investments.pluck(:interest_rate).reduce(:+)/investments.length

		investment_hash = {amount: total_amount, interest_rate: average_interest_rate}
	end

	def create_psuedo_investment
		investment_hash = {amount: 0, interest_rate: 0.07 }
	end

  def total_monthly_income
    incomes.pluck(:source_amount).reduce(:+)
  end

  def cash_flow
    (total_monthly_income - total_monthly_spending) - total_min_monthly_payments
  end

  def three_months_spending
    total_monthly_spending * 3
  end

  def six_months_spending
    total_monthly_spending * 6
  end

  def savings
		accounts.where(a_type: "Savings").pluck(:amount).reduce(:+)
  end

end
