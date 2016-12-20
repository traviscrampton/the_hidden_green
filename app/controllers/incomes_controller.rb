class IncomesController < ApplicationController

	respond_to :json, only: [:index]

	def index
		user = User.find(params[:user_id])
		respond_with(user.incomes.to_json)
	end


	def new
		@income = @user.incomes.new()
	end

	def create
		@income = @user.incomes.new(income_params)
		@income.save!
		redirect_to new_monthly_spending_path
	end

	private

	def set_user
		@user = current_user
	end


	def income_params
		params.require(:monthly_income).permit(:source_name, :source_amount)
	end
end
