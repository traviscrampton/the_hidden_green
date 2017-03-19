class MonthlySpendingsController < ApplicationController

	respond_to :json, only:[:index, :create, :update, :destroy]

	def index
		monthly_spending = current_user.monthly_spending
		respond_with monthly_spending
	end

	def create
		monthly_spending = current_user.monthly_spendings.build(monthly_spending_params)
		monthly_spending.save!
		respond_with monthly_spending
	end

	def update
		monthly_spending = MonthlySpending.find params[:id]
		monthly_spending.update!(monthly_spending_params)
		respond_with monthly_spending

	end

	def destroy
		monthly_spending = MonthlySpending.find(params[:id])
		monthly_spending.destroy
		respond_with monthly_spending
	end


	private

	def monthly_spending_params
		params.require(:monthly_spending).permit(:rent, :food, :phone, :utilities, :everything_else)
	end

end
