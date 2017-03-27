class MonthsController < ApplicationController
	respond_to :json, only:[:show]

	def show
		month = Month.find(params[:id])
		full_month = SingleMonth.new(month).call
		respond_with full_month
	end
end
