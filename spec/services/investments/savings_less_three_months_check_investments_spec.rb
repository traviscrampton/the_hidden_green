require "rails_helper"

RSpec.describe Investments::SavingsLessThreeMonthsCheckInvestments do
	let(:month) { create(:month) }
	let(:service) { Investments::SavingsLessThreeMonthsCheckInvestments.new(month) }
	let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}


	context "enough investment to get a users savings to three_months_spending" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 10000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			monthly_spending
			savings
			investment
		end

		it "puts the savings account total to equal three months spending from investments" do
			service.call
			savings.reload
			expect(savings.amount).to eq month.three_months_spending
		end

		it "takes the proper amount from the investment to put in" do
			service.call
			investment.reload
			expect(investment.amount).to eq 5500
		end

		it "has the proper advices attached to the month" do
			service.call
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 4500.0 from your Big Time Stocks investment to your Bank Of America account")
		end
	end

	context "not enough investment to get user to three months spending" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 3000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			monthly_spending
			investment
			savings
		end

		it "puts as much as possible towards savings account" do
			service.call
			savings.reload
			expect(savings.amount).to eq 4200.0
		end

		it "takes sets investment equal to 0" do
			service.call
			investment.reload
			expect(investment.amount).to eq 0
		end

		it "adds the proper advices to the month" do
			service.call
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 3000.0 from your Big Time Stocks investment to your Bank Of America account")
		end

	end
end
