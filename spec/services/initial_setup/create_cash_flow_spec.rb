require "rails_helper"

RSpec.describe InitialSetup::CreateInitialCashFlow do


	context "cash flow with users attributes" do
		let(:user) { create(:user) }
		let(:income) { create(:income, source_amount: 3200, incomeable_id: user.id, incomeable_type: user.class.name) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: user.id, monthly_spendable_type: user.class.name, rent: 800, phone:100, utilities:50, food: 100, everything_else:100 )}
		let(:debt) { create(:debt, debtable_id: user.id, debtable_type: user.class.name, amount: 8000, minimum_monthly_payment:120 ) }
		let(:service) { InitialSetup::CreateInitialCashFlow.new(user) }

		before(:each) do
			monthly_spending
			debt
			income
		end
		it 'saves a cashflow entry for a user' do
			cash_flow = service.call
			expect(user.cash_flow).to be_persisted
		end
		it 'calculates the correct cash flow figure' do
			service.call
			expect(user.cash_flow.amount).to eq(1930.0)
		end
	end
end
