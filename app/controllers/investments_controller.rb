class InvestmentsController < ApplicationController

	respond_to :json, only: [:index, :create]

	def index
		investments = current_user.investments.sort_by{|i| i.created_at }.reverse
		respond_with investments
	end

	def create
		investment = current_user.investments.new(investment_params)
		investment.save!
		respond_with(investment)
	end


	private

	def investment_params
		params.require(:investment).permit(:name, :amount, :interest_rate)
	end

	def set_user
		@user = current_user
	end

end
