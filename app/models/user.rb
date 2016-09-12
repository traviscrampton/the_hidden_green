class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :monthly_spending
  has_many :accounts
  has_many :monthly_incomes
  has_many :assets
  has_many :debts
  has_many :investments

  accepts_nested_attributes_for :accounts


  def total_monthly_spending
    monthly_spending.food + monthly_spending.rent + monthly_spending.phone + monthly_spending.utilities + monthly_spending.everything_else
  end

  def total_debt
    total = 0
    debts.each do |debt|
      total += debt.amount
    end
    return total
  end

  def total_min_payments
    total = 0
    debts.each do |debt|
      total += debt.minimum_monthly_payment
    end
    return total
  end

  def total_investment
    total = 0
    investments.each do |investment|
      total += investment.amount
    end
    return total
  end

  def total_monthly_income
    total = 0
    monthly_incomes.each do |income|
      total += income.source_amount
    end
    return total
  end

  def cash_flow
    (total_monthly_income - total_monthly_spending) - total_min_payments
  end

  def three_months_spending
    total_monthly_spending * 3
  end

  def six_months_spending
    total_monthly_spending * 6
  end

  def has_debt
    advice = []
    debt = total_debt
    three_months = three_months_spending
    six_months = six_months_spending
    savings = accounts.find_by(a_type:'Savings').amount
    investment = total_investment
    if total_debt > 0
      if savings < three_months
        goal = three_months - savings
        advice.push("Your savings account needs to be atleast up to three months of spending for you that would be #{goal}")
        if goal > cash_flow
          advice.push("Your first months cash flow of $#{cash_flow}0 should go towards your three month cushion")
        else
          to_even = cash_flow - goal
          advice.push("Put #{goal} in your savings and then put #{to_even} towards your debt")
        end
      else
        advice.push("You have atleast three months savings ready to go, transfer #{savings - three_months_spending}0 towards paying off your debt.")
        advice.push("Your first months cash flow of #{cash_flow} should go towards crushing debt.")
      end
    else
      if savings < six_months
        goal = six_months - savings
        advice.push("Before you start investing you'll need to get #{goal} in your savings account for a 6 month cushion")
        if goal > cash_flow
          advice.push("Your first months cash flow of $#{cash_flow}0 should go towards your six month cushion")
        else
          to_even = cash_flow - goal
          advice.push("Put #{goal} in your savings and then put #{to_even} towards your debt")
        end
      else
        advice.push("You are debt free and have saved up enough money to party. Lets start investing your cash flow of #{cash_flow}")
      end
    end
    return advice
  end

end
