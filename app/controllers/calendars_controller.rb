class CalendarsController < ApplicationController

	def index
		@calendar = Calendar.new(current_user)
	end
end
