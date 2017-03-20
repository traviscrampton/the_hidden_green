class UsersController < ApplicationController

	before_action :set_user

	def show
		FinancialForcast::CalculationMatrix.new(current_user.months.first).call
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
