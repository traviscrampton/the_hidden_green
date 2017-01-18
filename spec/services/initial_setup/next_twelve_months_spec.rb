require 'rails_helper'

RSpec.describe InitialSetup::NextTwelveMonthScope do

	context "Generates 12 months from #{Time.now}" do
		let(:service) { InitialSetup::NextTwelveMonthScope.new}
		it "generates 12 new months" do
			next_months = service.call
			expect(next_months.length).to eq 13
		end
	end
end
