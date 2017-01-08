class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!

	def dashboard
		InitialSetup::CreateInitialYearView.new(current_user).call
	end

end
