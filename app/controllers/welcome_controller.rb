class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!

	def dashboard
		CreateInitialYearView.new(User.find(1)).call
	end

end
