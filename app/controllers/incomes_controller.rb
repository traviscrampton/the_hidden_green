class IncomesController < ApplicationController

	respond_to :json, only: [:index, :create]

	def index
		user = User.find(params[:user_id])
		respond_with(user.incomes.to_json)
	end


	def new
		@income = @user.incomes.new()
	end

	def create
		income = current_user.incomes.new(income_params)
		income.save!
		respond_with(income)
	end

	private

	def set_user
		@user = current_user
	end


	def income_params
		params.require(:income).permit(:source_name, :source_amount)
	end
end
