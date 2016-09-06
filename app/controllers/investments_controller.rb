class InvestmentsController < ApplicationController

	before_action :set_user

	def index
		@investments = @user.investments
	end

	def new
		@investment = @user.investments.new()
		respond_to do |format|
			format.js
		end
	end

	def create
		@investment = @user.investments.new(investment_params)
		@investment.save
		respond_to do |format|
			format.js
		end
	end

	private

	def investment_params
		params.require(:investment).permit(:name, :amount, :interest_rate)
	end

	def set_user
		@user = current_user
	end

end
