require "rails_helper"

RSpec.describe InitialSetup::CreateMonths do
	context "no months are created runs service to create months" do
		let(:user) { create(:user) }
		let(:service) { InitialSetup::CreateMonths.new(user) }

		before(:each) do
			service.call
		end

		it "creates an array of 13 months" do
			expect(user.months.length).to eq 13
		end

		it "creates months up to the the current month a year from now" do
			expect(user.months.last.year).to eq((Time.now + 1.year).strftime('%Y').to_i)
			expect(user.months.last.name).to eq((Time.now + 1.year).strftime('%B'))
		end
	end

	context "months already exist" do
		let(:user) { create(:user) }
		let(:service) { InitialSetup::CreateMonths.new(user)}

		it "doesn't create any extra months" do
			service.call
			service.call
			expect(user.months.length).to eq(13)
		end

	end
end
