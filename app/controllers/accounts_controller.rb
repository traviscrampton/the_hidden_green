class AccountsController < ApplicationController
	before_action :set_user
	before_action :next_pls, only: [:new]

	def new
		2.times {@user.accounts.new()}
	end


private
	def set_user
		@user = current_user
	end

	def next_pls
		redirect_to new_monthly_income_path() if @user.accounts.length == 2
	end
end
