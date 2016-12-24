class AccountsController < ApplicationController

	respond_to :json, only: [:index, :create]

	def index
		user = User.find(params[:user_id])
		respond_with(user.accounts.sort_by{|a| a.a_type }.reverse)
	end

	def create
		account = current_user.accounts.new(account_params)
		account.save!
		respond_with account
	end


	private

	def set_user
		@user = current_user
	end

	def account_params
		params.require(:account).permit(:name, :amount, :a_type, :interest_rate)
	end

end
