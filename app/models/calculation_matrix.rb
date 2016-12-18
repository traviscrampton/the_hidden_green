class CalculationMatrix
	extend Forwardable

	def_delegators :user
	attr_accessor :user

	def initialize(user)
		self.user = user
	end

	def financial_shuffle(debt, savings, total_investment, advice_array)
		if debt > 0
			has_debt_check_savings(debt, savings, total_investment, advice_array)
		else
			no_debt_check_savings(debt, savings, total_investment, advice_array)
		end
	end

	def has_debt_check_savings(debt, savings, total_investment, advice_array)
		if savings < user.three_months_spending
			goal = user.three_months_spending - savings
			savings_less_than_3_months_check_investments(debt, savings, total_investment, advice_array, goal)
		else
			transfer_savings_to_debt(debt, savings, total_investment, advice_array)
		end
	end

	def savings_less_than_3_months_check_investments(debt, savings, total_investment, advice_array, goal)
		if total_investment[:amount] > 0
			investments_to_savings(debt, savings, total_investment, advice_array, goal)
		else
			cash_flow_to_savings(debt, savings, total_investment, advice_array, goal)
		end
	end

	def transfer_savings_to_debt(debt, savings, total_investment, advice_array)
		immediate_transfer = savings - user.three_months_spending
		if debt >= immediate_transfer
			pay_off_portion_of_debt_savings(debt, savings, total_investment, advice_array, immediate_transfer)
		else
			pay_off_all_debt_from_savings(debt, savings, total_investment, advice_array, immediate_transfer)
		end
	end

	def pay_off_portion_of_debt_savings(debt, savings, total_investment, advice_array, immediate_transfer)
		debt -= immediate_transfer
		advice_array.push("transfer #{immediate_transfer} from your savings towards your debt") unless immediate_transfer == 0
		more_savings_look_at_investment(debt, savings, total_investment, advice_array)
	end

	def pay_off_all_debt_from_savings(debt, savings, total_investment, advice_array, immediate_transfer)
	  advice_array.push("transfer #{debt} from your savings account to pay off all your debt")
	  savings -= debt
	  debt = 0
	  financial_shuffle(debt, savings, total_investment, advice_array)
	end

	def no_debt_check_savings(debt, savings, total_investment, advice_array)
	  if savings < user.six_months_spending
	    savings_less_than_6_months_check_investments(debt, savings, total_investment, advice_array)
	  else
			cash_flow_to_investment(debt, savings, total_investment, advice_array)
	  end
	end

	def savings_less_than_6_months_check_investments(debt, savings, total_investment, advice_array)
		goal = user.six_months_spending - savings
		 if total_investment[:amount] > 0
			 investments_to_savings(debt, savings, total_investment, advice_array, goal)
		 else

		 end
	end

	def investments_to_savings(debt, savings, total_investment, advice_array, goal)
		if total_investment[:amount] >= goal
			total_investment[:amount] -= goal
			advice_array.push("Transfer #{goal} from your investments and put it towards your savings")

			# investment_to_pay_debt(debt, savings, total_investment, advice_array)
		else
			goal -= total_investment[:amount]
			total_investment[:amount] = 0
		end
	end

	def investment_to_pay_debt(debt, savings, total_investment, advice_array)

	end

	def cash_flow_to_savings(debt, savings, total_investment, advice_array, goal)
		if goal >= user.cash_flow
			savings += user.cash_flow
			advice_array.push("This months cash flow of #{user.cash_flow} should go towards your savings")
			final_function(debt, savings, total_investment, advice_array)
		else
			savings += (user.cash_flow - goal)
			advice_array.push("This months cash flow of #{user.cash_flow - goal} should go towards savings")
			financial_shuffle(debt, savings, total_investment, advice_array)
		end
	end


	## cash_flow_to_investment really just means that you've lined up your ducks and are taking care of business.


	def cash_flow_to_investment(debt, savings, total_investment, advice_array)
		advice_array.push("This months cash flow of #{user.cash_flow} should go towards your investments")
		total_investment[:amount] += user.cash_flow

		final_function(debt, savings, total_investment, advice_array)
	end

	def final_function(debt, savings, total_investment, advice_array)
		{debt: debt, savings: savings, total_investment: total_investment, advice_array: advice_array}
	end



end
