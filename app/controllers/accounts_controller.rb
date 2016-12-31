class AccountsController < ApplicationController

	respond_to :json, only: [:index, :create, :update, :destroy]

	def index
		user = User.find(params[:user_id])
		accounts = user.accounts.order('created_at ASC')
		respond_with accounts
	end

	def create
		account = current_user.accounts.new(account_params)
		account.save!
		respond_with account
	end

	def update
		account = Account.find params[:id]
		account.update(account_params)
		respond_with account
	end

	def destroy
		account = Account.find(params[:id])
		account.destroy
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
