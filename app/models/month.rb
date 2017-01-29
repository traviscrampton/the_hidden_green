class Month < ActiveRecord::Base

	belongs_to :user
	has_one :monthly_spending, as: :monthly_spendable
	has_one :cash_flow, as: :cash_flowable, dependent: :destroy
	has_many :advices, as: :adviceable, dependent: :destroy
	has_many :debts, as: :debtable, dependent: :destroy
	has_many :accounts, as: :accountable, dependent: :destroy
	has_many :incomes, as: :incomeable, dependent: :destroy
	has_many :investments, as: :investmentable, dependent: :destroy


	def total_monthly_spending
		values = monthly_spending.attributes.except("id", "monthly_spendable_id", "monthly_spendable_type", "created_at", "updated_at").values
		values.reduce(:+)
  end

  def total_debt
		debts.any? ? debts.pluck(:amount).reduce(:+) : 0
  end

	def has_debt?
		total_debt > 0
	end

	def total_investment
		investments.any? ? investments.pluck(:amount).reduce(:+) : 0
	end

	def has_investment?
		total_investment > 0
	end

	def total_savings
		accounts.where(a_type: "savings").pluck(:amount).reduce(:+)
	end

	def has_cash_flow?
		cash_flow.amount > 0
	end

	def less_than_three_months
		month.total_savings < month.three_months_spending
	end

	def which_spending
		total_debt > 0 ? month.three_months_spending : month.six_months_spending
	end




	def order_debt_by_highest_interest_rate
		debts.order('interest_rate DESC')
	end

	def order_savings_by_lowest_interest_rate
		accounts.where(a_type:'savings').order('interest_rate ASC')
	end

	def order_investment_by_lowest_rate
		investments.order('interest_rate ASC')
	end

  def total_min_monthly_payments
		debts.any? ? debts.pluck(:minimum_monthly_payment).reduce(:+) : 0
  end

  def total_monthly_income
    incomes.pluck(:source_amount).reduce(:+)
  end

  def monthly_cash_flow
     total_monthly_income - total_monthly_spending
  end

  def three_months_spending
    total_monthly_spending * 3
  end

  def six_months_spending
    total_monthly_spending * 6
  end

	def attrs
		options = {}
		options['debts'] = debts
		options['accounts'] = accounts
		options['incomes'] = incomes
 		options['monthly_spending'] = monthly_spending
		options['investments'] = investments
		options['cash_flow'] = cash_flow
		options['advices'] = advices
		return options
	end
end
