require 'rails_helper'

RSpec.describe Investments::TransferInvestmentToDebt do

	let(:month) { create(:month) }
	let(:service) { Investments::TransferInvestmentToDebt.new(month) }

	context "one debt, one investment, able to pay off everything" do
		let(:debt) { create(:debt, amount: 3000, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.08 )}
		let(:investment) { create(:investment, amount: 5000, name:'Big Stock Investment', interest_rate: 0.09, investmentable_id: month.id, investmentable_type:month.class )}

		before(:each) do
			debt
			investment
		end

		it "sets the debt equal to zero" do
			service.call
			debt.reload
			expect(debt.amount).to eq 0
		end

		it "subtracts the proper amount from investment" do
			service.call
			investment.reload
			expect(investment.amount).to eq 2000
		end

		it "gives the proper advice" do
			service.call
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 3000.0 from your Big Stock Investment to your Student Loan")
		end
	end
end
