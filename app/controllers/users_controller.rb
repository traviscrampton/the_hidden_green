class UsersController < ApplicationController

	before_action :set_user

	def show
		@matrix_results = CalculationMatrix.new(@user).financial_shuffle(@user.total_debt, @user.savings, @user.total_investment, @user.cash_flow, [])
		@debt = @matrix_results[:debt]
		@savings = @matrix_results[:savings]
		@total_investment_amount = @user.total_investment[:amount]
		@advice = @matrix_results[:advice]
		@months_from_now = Calendar.new(user: @user).re_order_year
	end

	def update
		@user.update_attributes(account_params)
		redirect_to new_monthly_income_path
	end

	private

	def set_user
		@user = current_user
	end

	def account_params
		params.require(:user).permit(accounts_attributes: [:id, :a_type, :amount, :interest_rate])
	end
end
