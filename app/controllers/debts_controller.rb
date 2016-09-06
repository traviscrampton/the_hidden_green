class DebtsController < ApplicationController

	before_action :set_user

	def index
		@debts = @user.debts
	end

	def new
		@debt = @user.debts.new()
		respond_to do |format|
			format.js
		end
	end

	def create
		@debt = @user.debts.new(debt_params)
		@debt.save
		respond_to do |format|
			format.js
		end
	end

	private

	def debt_params
		params.require(:debt).permit(:name, :amount, :interest_rate, :minimum_monthly_payment)
	end

	def set_user
		@user = current_user
	end

end
