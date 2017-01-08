class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :months
  has_one :monthly_spending, as: :monthly_spendable
  has_many :accounts, as: :accountable
  has_many :incomes, as: :incomeable
  # has_many :assets, as: :assetable
  has_many :debts, as: :debtable
  has_many :investments, as: :investmentable

  accepts_nested_attributes_for :accounts


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

  # #### CALCULATION MATRIX ####

  def financial_shuffle(*args)
    debt > 0 ? look_at_debt(args) :  check_savings(args)
  end

  def look_at_debt(*args)
		savings < three_months_spending ? less_savings_look_at_investment(args) : debt_and_savings_scramble(args)
  end

  def less_savings_look_at_investment(debt, savings, investment_hash, advice_array)
    new_hash = {}
    goal = three_months_spending - savings
    investment_hash.each do |name, amount|
      next if savings >= three_months_spending
      if amount[0] >= goal
        new_hash[name] = [goal, "TO SAVINGS"]
        amount[0] -= goal
        savings += goal
      elsif amount[0] < goal
        new_hash[name] = [amount[0], "TO SAVINGS"]
        goal -= amount[0]
        savings += amount[0]
        amount[0] = 0
      end
    end

    new_hash.each do |key, score|
      advice_array.push("Move #{score[0]} from the #{key} account #{score[1]}")
    end

    if savings < three_months_spending
      first_months_spending_towards_savings(debt, savings, advice_array, investment_hash, three_months_spending)
    else
      financial_shuffle(debt, savings, investment_hash, advice_array)
    end
  end

  def check_savings(debt, savings, investment_hash, advice_array)
    if savings < six_months_spending
      six_months_spending_check_investments(debt, savings, investment_hash, advice_array)
    else
      advice_array.push("Your this months cash flow of #{cash_flow} should go towards some type of investment")
      investment_hash.sort_by{|_, val| -1 * val[1]}.first[1][0] += cash_flow
      state_change(debt, savings, investment_hash, advice_array)
    end
  end

  def six_months_spending_check_investments(debt, savings, investment_hash, advice_array)
    new_hash = {}
    goal = six_months_spending - savings
    investment_hash.each do |name, amount|
      next if savings >= six_months_spending
      if amount[0] >= goal
        new_hash[name] = [goal, "TO SAVINGS"]
        amount[0] -= goal
        savings += goal
      elsif amount[0] < goal
        new_hash[name] = [amount[0], "TO SAVINGS"]
        goal -= amount[0]
        savings += amount[0]
        amount[0] = 0
      end
    end

    new_hash.each do |key, score|
      advice_array.push("Move #{score[0]} from the #{key} account #{score[1]}")
    end

    if savings < six_months_spending
      first_months_spending_towards_savings(debt, savings, advice_array, investment_hash, six_months_spending)
    else
      state_change(debt, savings, investment_hash, advice_array)
    end
  end

  def first_months_spending_towards_savings(debt, savings, advice_array, investment_hash, x_months_spending)
    goal = x_months_spending - savings
    if goal > cash_flow
      advice_array.push("Your this months cashflow of #{cash_flow} should go towards your savings")
      savings += cash_flow
    else
      advice_array.push("#{cash_flow - goal} of your this months cashflow should go towards your savings")
      savings += (cash_flow - goal)
    end
    state_change(debt, savings, investment_hash, advice_array)
  end

  def debt_and_savings_scramble(debt, savings, investment_hash, advice_array)
    immediate_transfer = savings - three_months_spending
    if debt >= immediate_transfer
      debt -= immediate_transfer
      advice_array.push("transfer #{immediate_transfer} from your savings towards your debt") unless immediate_transfer == 0
      more_savings_look_at_investment(debt, savings, investment_hash, advice_array)
    else
      advice_array.push("transfer #{debt} from your savings account to pay off all your debt")
      savings -= debt
      debt = 0
      check_savings(debt, savings, investment_hash, advice_array)
    end
  end



  def more_savings_look_at_investment(debt, savings, investment_hash, advice_array)
    sort_hash = {}
    investment_hash.each do |name, amount|
      next if debt == 0
      if amount[0] > debt
        sort_hash[name] = [debt, "TO DEBT"]
        debt = 0
      else
        debt -= amount[0]
        sort_hash[name] = [amount[0], "TO DEBT"]
      end
    end
    sort_hash.each do |key, score|
      advice_array.push("Move #{score[0]} from the #{key} account #{score[1]}")
    end

    if debt != 0
      first_months_spending_towards_debt(debt, savings, investment_hash, advice_array)
    end

    state_change(debt, savings, investment_hash, advice_array)
  end

  def first_months_spending_towards_debt(debt, savings, investment_hash, advice_array)
    if debt > cash_flow
      advice_array.push("Your this months cashflow of #{cash_flow} should go towards your debt")
      debt -= cash_flow
    else
      advice_array.push("#{cash_flow - debt} of your this months cashflow should go towards your savings")
      savings += (cash_flow - debt)
    end
    state_change(debt, savings, investment_hash, advice_array)
  end

  def investment_hashitize
		i_hash = Hash.new
		investments.map{ |i| i_hash[i.name] = [i.amount, i.interest_rate]}
		return i_hash
  end

  def state_change(debt, savings, investment_hash, advice_array)
    hasher = {}
    debt = debt - total_min_monthly_payments if debt > total_min_monthly_payments
    hasher["debt"] = debt - total_min_monthly_payments
    hasher["savings"] = savings
    hasher["investment_hash"] = investment_hash
    hasher["advice_array"] = advice_array
    return hasher
  end

end
