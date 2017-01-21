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

	context "2 investment accounts 2 savings accounts" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 3000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}
		let(:savings_2) { create(:account, a_type:'savings', name:'Grandmas Fund', amount: 2200, interest_rate: 0.09, accountable_id: month.id, accountable_type:month.class)}
		let(:investment_2) { create(:investment, name:'S&B 500', amount: 7000, interest_rate:0.08, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			savings
			savings_2
			investment
			investment_2
			monthly_spending
		end

		it "gets total savings to three months spending" do
			service.call
			savings.reload
			savings_2.reload
			expect(month.savings).to eq month.three_months_spending
		end

		it "adds money to the savings with the higher interest rate" do
			service.call
			savings.reload
			expect(savings.amount).to eq 3500.0
		end

		it "does not add anything to the lower interest rate" do
			service.call
			savings_2.reload
			expect(savings_2.amount).to eq 2200.0
		end

		it 'takes away the amount from the lower investment amount' do
			service.call
			investment_2.reload
			expect(investment_2.amount).to eq 4700
		end

		it "doesn't take anything away from the higher investment (in this context)" do
			service.call
			investment.reload
			expect(investment.amount).to eq 3000.0
		end

		it "creates the proper advices" do
			service.call
			investment_2.reload
			savings.reload
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 2300.0 from your #{investment_2.name} investment to your #{savings.name} account")
		end
	end
end
