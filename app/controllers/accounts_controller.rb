class AccountsController < ApplicationController

		respond_to :json, only: [:index]

		def index
			user = User.find(params[:user_id])
			respond_with(user.accounts.sort_by{|a| a.a_type }.reverse)
		end

		def new
			@user = User.find(1)
		end

private
	def set_user
		@user = current_user
	end

	def next_pls
		redirect_to new_monthly_income_path() if @user.accounts.length == 2
	end
end
