class DebtsController < ApplicationController

	respond_to :json, only:[:index, :create, :destroy]

	def index
		debts = current_user.debts.sort_by{|d| d.created_at }.reverse
		respond_with debts
	end

	def create
		debt = current_user.debts.new(debt_params)
		debt.save!
		respond_with(debt)
	end

	def destroy
		debt = Debt.find(params[:id])
		debt.destroy
		respond_with(debt)
	end

	private

	def debt_params
		params.require(:debt).permit(:name, :amount, :interest_rate, :minimum_monthly_payment)
	end

	# def set_user
	# 	@user = current_user
	# end

end
