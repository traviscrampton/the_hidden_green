class MonthlySpendingsController < ApplicationController

	before_action :set_user
	before_action :next_pls, only:[:new]

	def new
		@monthly_spending = @user.build_monthly_spending
	end

	def create
		@monthly_spending = @user.build_monthly_spending(monthly_spending_params)
		@monthly_spending.save!
		redirect_to debts_path
	end

	private

	def set_user
		@user = current_user
	end

	def next_pls
		redirect_to user_path(@user) if @user.monthly_spending
	end

	def monthly_spending_params
		params.require(:monthly_spending).permit(:rent, :food, :phone, :utilities, :everything_else)
	end
end
