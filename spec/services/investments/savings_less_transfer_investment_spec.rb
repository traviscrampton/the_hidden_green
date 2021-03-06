require "rails_helper"

RSpec.describe Investments::SavingsLessTransferInvestment do
	let(:month) { create(:month) }
	let(:service) { Investments::SavingsLessTransferInvestment.new(month) }
	let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
	let(:debt) { create(:debt, debtable_id: month.id, debtable_type:month.class, name:'Student Loan', amount: 1, interest_rate:0.09)}


	context "enough investment to get a users savings to three_months_spending" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 10000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			debt
			monthly_spending
			savings
			investment
			service.call
			savings.reload
			investment.reload
		end

		it "puts the savings account total to equal three months spending from investments" do
			expect(savings.amount).to eq month.three_months_spending
		end

		it "takes the proper amount from the investment to put in" do
			expect(investment.amount).to eq 5500
		end

		it "has the proper advices attached to the month" do
			advice = month.advices.first
			expect(advice.to).to eq(savings)
			expect(advice.from).to eq(investment)
			expect(advice.amount).to eq(4500.0)
		end
	end

	context "not enough investment to get user to three months spending" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 3000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			monthly_spending
			investment
			savings
			service.call
			investment.reload
			savings.reload
		end

		it "puts as much as possible towards savings account" do
			expect(savings.amount).to eq 4200.0
		end

		it "takes sets investment equal to 0" do
			expect(investment.amount).to eq 0
		end

		it "adds the proper advices to the month" do
			advice = month.advices.first
			expect(advice.to).to eq(savings)
			expect(advice.from).to eq(investment)
			expect(advice.amount).to eq(3000.0)
		end
	end

	context "2 investment accounts 2 savings accounts" do
		let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', amount: 1200, interest_rate: 0.10, accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'Big Time Stocks', amount: 3000, interest_rate:0.09, investmentable_id: month.id, investmentable_type: month.class)}
		let(:savings_2) { create(:account, a_type:'savings', name:'Grandmas Fund', amount: 2200, interest_rate: 0.09, accountable_id: month.id, accountable_type:month.class)}
		let(:investment_2) { create(:investment, name:'S&B 500', amount: 7000, interest_rate:0.08, investmentable_id: month.id, investmentable_type: month.class)}

		before(:each) do
			monthly_spending
			debt
			savings
			savings_2
			investment
			investment_2
			service.call
			savings.reload
			savings_2.reload
			investment.reload
			investment_2.reload
		end

		it "gets total savings to three months spending" do
			service.call
			savings.reload
			savings_2.reload
			expect(month.total_savings).to eq month.three_months_spending
		end

		it "adds money to the savings with the higher interest rate" do
			expect(savings.amount).to eq 3500.0
		end

		it "does not add anything to the lower interest rate" do
			expect(savings_2.amount).to eq 2200.0
		end

		it 'takes away the amount from the lower investment amount' do
			expect(investment_2.amount).to eq 4700
		end

		it "doesn't take anything away from the higher investment (in this context)" do
			expect(investment.amount).to eq 3000.0
		end

		it "creates the proper advices" do
			advice = month.advices.first
			expect(advice.to).to eq(savings)
			expect(advice.from).to eq(investment_2)
			expect(advice.amount).to eq(2300.0)
		end
	end
end
