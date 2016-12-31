class InvestmentsController < ApplicationController

	respond_to :json, only: [:index, :create, :update, :destroy]

	def index
		investments = current_user.investments.order('created_at ASC')
		respond_with investments
	end

	def create
		investment = current_user.investments.new(investment_params)
		investment.save!
		respond_with(investment)
	end

	def update
		investment = Investment.find params[:id]
		investment.update(investment_params)
		respond_with investment
	end

	def destroy
		investment = Investment.find(params[:id])
		investment.destroy
		respond_with investment
	end


	private

	def investment_params
		params.require(:investment).permit(:name, :amount, :interest_rate)
	end

	def set_user
		@user = current_user
	end

end
