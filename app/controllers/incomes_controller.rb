class IncomesController < ApplicationController

	respond_to :json, only: [:index, :create, :update, :destroy]

	def index
		incomes = current_user.incomes.order('created_at ASC')
		respond_with incomes
	end

	def create
		income = current_user.incomes.new(income_params)
		income.save!
		respond_with income
	end

	def update
		income = Income.find params[:id]
		income.update(income_params)
		respond_with income
	end

	def destroy
		income = Income.find(params[:id])
		income.destroy
		respond_with income
	end

	private

	def set_user
		@user = current_user
	end


	def income_params
		params.require(:income).permit(:source_name, :source_amount)
	end
end
