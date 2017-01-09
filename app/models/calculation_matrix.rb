class CalculationMatrix
	extend Forwardable

	def_delegators :user
	attr_accessor :user

	def initialize(user)
		self.user = user
	end

	def financial_shuffle(debt, savings, total_investment, cash_flow, advice)
		if debt > 0
			has_debt_check_savings(debt, savings, total_investment, cash_flow, advice)
		else
			no_debt_check_savings(debt, savings, total_investment, cash_flow, advice)
		end
	end

	def has_debt_check_savings(debt, savings, total_investment, cash_flow, advice)
		if savings < user.three_months_spending
			goal = user.three_months_spending - savings
			savings_less_than_3_months_check_investments(debt, savings, total_investment, cash_flow, advice, goal)
		else
			transfer_savings_to_debt(debt, savings, total_investment, cash_flow, advice)
		end
	end

	def savings_less_than_3_months_check_investments(debt, savings, total_investment, cash_flow, advice, goal)
		if total_investment[:amount] > 0
			investments_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		else
			cash_flow_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		end
	end

	def transfer_savings_to_debt(debt, savings, total_investment, cash_flow, advice)
		immediate_transfer = savings - user.three_months_spending
		if debt >= immediate_transfer
			pay_off_portion_of_debt_savings(debt, savings, total_investment, cash_flow, advice, immediate_transfer)
		else
			pay_off_all_debt_from_savings(debt, savings, total_investment, cash_flow, advice, immediate_transfer)
		end
	end

	def pay_off_portion_of_debt_savings(debt, savings, total_investment, cash_flow, advice, immediate_transfer)
		savings -= immediate_transfer
		debt -= immediate_transfer
		advice.push("transfer #{immediate_transfer} from your savings towards your debt") unless immediate_transfer == 0
		three_months_spending_has_debt_look_at_investment(debt, savings, total_investment, cash_flow, advice)
	end

	def three_months_spending_has_debt_look_at_investment(debt, savings, total_investment, cash_flow, advice)
		if total_investment[:amount] > 0
			investment_to_pay_debt(debt, savings, total_investment, cash_flow, advice)
		else
			cash_flow_to_debt(debt, savings, total_investment, cash_flow, advice)
		end
	end

	def pay_off_all_debt_from_savings(debt, savings, total_investment, cash_flow, advice, immediate_transfer)
	advice.push("transfer #{debt} from your savings account to pay off all your debt")
	savings -= debt
	debt = 0
	financial_shuffle(debt, savings, total_investment, cash_flow, advice)
	end

	def no_debt_check_savings(debt, savings, total_investment, cash_flow, advice)
	  if savings < user.six_months_spending
	    savings_less_than_6_months_check_investments(debt, savings, total_investment, cash_flow, advice)
	  else
			savings_more_than_6_months_check_investments(debt, savings, total_investment, cash_flow, advice)
	  end
	end

	def savings_more_than_6_months_check_investments(debt, savings, total_investment, cash_flow, advice)
		transfer = savings - user.six_months_spending
		total_investment[:amount] += transfer
		savings = user.six_months_spending
		advice.push("Move #{transfer} from your savings into your investments") unless transfer == 0
		cash_flow_to_investment(debt, savings, total_investment, cash_flow, advice)
	end

	def savings_less_than_6_months_check_investments(debt, savings, total_investment, cash_flow, advice)
		goal = user.six_months_spending - savings
		 if total_investment[:amount] > 0
			 investments_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		 else
			 cash_flow_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		 end
	end

	def investments_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		if total_investment[:amount] >= goal
			total_investment[:amount] -= goal
			savings += goal
			advice.push("Transfer #{goal} from your investments and put it towards your savings")
		else
			savings += total_investment[:amount]
			advice.push("Transfer #{total_investment[:amount]} from your investment to your savings")
			total_investment[:amount] = 0
		end
		financial_shuffle(debt, savings, total_investment, cash_flow, advice)
	end

	def investment_to_pay_debt(debt, savings, total_investment, cash_flow, advice)
		if debt >= total_investment[:amount]
			advice.push("Transfer #{total_investment[:amount]} from your investments towards your debt")
			debt -= total_investment[:amount]
			total_investment[:amount] = 0
		else
			advice.push("Transfer #{debt} from your investments to pay off all your debt!")
			total_investment[:amount] -= debt
			debt = 0
		end
		financial_shuffle(debt, savings, total_investment, cash_flow, advice)
	end

	def cash_flow_to_savings(debt, savings, total_investment, cash_flow, advice, goal)
		if goal >= cash_flow
			savings += cash_flow
			advice.push("This months cash flow of #{cash_flow} should go towards your savings")
			cash_flow = 0
			final_function(debt, savings, total_investment, cash_flow, advice)
		else
			savings += goal
			cash_flow -= goal
			advice.push("This months cash flow of #{goal} should go towards savings")
			financial_shuffle(debt, savings, total_investment, cash_flow, advice)
		end
	end

	def cash_flow_to_debt(debt, savings, total_investment, cash_flow, advice)
		if debt >= cash_flow
			debt -= cash_flow
			advice.push("$#{cash_flow} should go towards paying off your debt ")
			cash_flow = 0
			final_function(debt, savings, total_investment, cash_flow, advice)
		else
			cash_flow -= debt
			advice.push("your cash flow of #{debt} should go to pay off your debt")
			debt = 0
			financial_shuffle(debt, savings, total_investment, cash_flow, advice)
		end
	end

	def cash_flow_to_investment(debt, savings, total_investment, cash_flow, advice)
		advice.push("This months cash flow of #{cash_flow} should go towards your investments")
		total_investment[:amount] += cash_flow

		final_function(debt, savings, total_investment, cash_flow, advice)
	end

	def final_function(debt, savings, total_investment, cash_flow, advice)
		{debt: debt, savings: savings, total_investment: total_investment, cash_flow: cash_flow, advice: advice}
	end



end
