class MonthlyIncomesController < ApplicationController

	before_action :set_user
	before_action :next_pls, only: [:new]

	def new
		@monthly_income = @user.monthly_incomes.new()
	end

	def create
		@income = @user.monthly_incomes.new(monthly_income_params)
		@income.save!
		redirect_to new_monthly_spending_path
	end

	private

	def set_user
		@user = current_user
	end

	def next_pls
		redirect_to new_monthly_spending_path() if @user.monthly_incomes.any?
	end

	def monthly_income_params
		params.require(:monthly_income).permit(:source_name, :source_amount)
	end
end
