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
    total_monthly_income - total_monthly_spending
  end

  def three_months_spending
    total_monthly_spending * 3
  end

  def six_months_spending
    total_monthly_spending * 6
  end

  # def initial_calculation_shuffle
  #   advice_array = []
  #   totes_debt = total_debt
  #   savings = accounts.find_by(a_type:"Savings").amount
  #   checking = accounts.find_by(a_type:"Checkings").amount
  #   if total_debt > 0
  #     if savings < three_months_spending
  #       if total_investment > 0
  #         savings_to_go = three_months_spending - savings
  #         new_investment_hash = {}
  #         investments.each do |invest|
  #           if savings_to_go >= invest.amount
  #             advice_array.push("Transfer #{invest.amount} from #{invest.name} to your savings account")
  #             savings_to_go -= invest.amount
  #             new_investment_hash[invest.id.to_s.to_sym] = [invest.name, 0]
  #           elsif savings_to_go < invest.amount
  #             new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount - savings_to_go]
  #             advice_array.push("Transfer #{savings_to_go}0 from #{invest.name} to your savings account")
  #           else
  #             new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount]
  #           end
  #         end
  #         new_investment_hash.each do |key, value|
  #           next if value[1] == 0
  #             if total_debt >= value[1]
  #               advice_array.push("Transfer #{value[1]} from your #{value[0]} and put it towards your debt")
  #             elsif total_debt < value[1]
  #               advice_array.push("Transfer #{total_debt} from your #{value[0]} account ")
  #             end
  #         end
  #       end
  #     else
  #       new_investment_hash = {}
  #       investments.each do |invest|
  #         if totes_debt >= invest.amount
  #           advice_array.push("Transfer #{invest.amount} from #{invest.name} towards your debt")
  #           totes_debt -= invest.amount
  #           new_investment_hash[invest.id.to_s.to_sym] = [invest.name, 0]
  #         elsif savings_to_go < invest.amount
  #           new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount - savings_to_go]
  #           advice_array.push("Transfer #{total_debt}0 from #{invest.name} to your savings account")
  #         else
  #           new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount]
  #         end
  #       end
  #       new_investment_hash.each do |key, value|
  #         next if value[1] == 0
  #           if total_debt >= value[1]
  #             advice_array.push("Transfer #{value[1]} from your #{value[0]} and put it towards your debt")
  #           elsif total_debt < value[1]
  #             advice_array.push("Transfer #{total_debt} from your #{value[0]} account ")
  #           end
  #       end
  #
  #     end
  #   else
  #     new_investment_hash = {}
  #     savings_to_go = six_months_spending - savings
  #     investments.each do |invest|
  #       if savings_to_go >= invest.amount
  #         advice_array.push("Transfer #{invest.amount} from #{invest.name} to your savings account")
  #         savings_to_go -= invest.amount
  #         new_investment_hash[invest.id.to_s.to_sym] = [invest.name, 0]
  #       elsif savings_to_go < invest.amount
  #         new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount - savings_to_go]
  #         advice_array.push("Transfer #{savings_to_go}0 from #{invest.name} to your savings account")
  #       else
  #         new_investment_hash[invest.id.to_s.to_sym] = [invest.name, invest.amount]
  #       end
  #     end
  #   end
  #   return advice_array
  # end
end
