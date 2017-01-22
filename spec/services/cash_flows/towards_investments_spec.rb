require "rails_helper"

RSpec.describe CashFlows::TowardsInvestments do
	context "has a cash flow and adds it to the investment" do
		let(:month) { create(:month) }
		let(:investment) { create(:investment, amount: 0, name:'Big Stock Investment', interest_rate:0.09, investmentable_id: month.id, investmentable_type:month.class )}
		let(:cash_flow) { create(:cash_flow, cash_flowable_id:month.id, cash_flowable_type:month.class, amount: 2000 )}
		let(:service) { CashFlows::TowardsInvestments.new(month) }

		before(:each) do
			investment
			cash_flow
			service.call
			cash_flow.reload
			investment.reload
		end

		it "sets the cash_flow equal to zero" do
			expect(month.cash_flow.amount).to eq 0
		end

		it "adds the cash flow to the investment" do
			expect(investment.amount).to eq 2000.0
		end

		it "adds the proper advice" do
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Cash flow of 2000.0 should go towards Big Stock Investment")
		end
	end
end
