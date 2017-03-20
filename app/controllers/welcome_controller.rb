class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!
	respond_to :json, only:[:yearview]


	def dashboard

	end

	def yearview
		unless current_user.initial_setup
			InitialSetup::CreateInitialYearView.new(current_user).call
		end
		respond_with true
	end


end
