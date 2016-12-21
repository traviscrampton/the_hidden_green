class DebtsController < ApplicationController

	respond_to :json, only: [:index]

	def index
		user = User.find(params[:user_id])
		respond_with(user.debts.to_json)
	end

	def new
		@debt = @user.debts.new()
		respond_to do |format|
			format.js
		end
	end

	def create
		binding.pry
	end

	private

	def debt_params
		params.require(:debt).permit(:name, :amount, :interest_rate, :minimum_monthly_payment)
	end

	# def set_user
	# 	@user = current_user
	# end

end
