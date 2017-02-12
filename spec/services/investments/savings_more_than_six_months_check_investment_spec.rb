require 'rails_helper'


RSpec.describe Investments::SavingsMoreThanSixMonthsCheckInvestment do
	let(:month) { create(:month) }
	let(:service) { Investments::SavingsMoreThanSixMonthsCheckInvestment.new(month) }

	let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}

	context "one savings account" do
		let(:savings) { create(:account, a_type:'savings', amount:15000, interest_rate:0.08, name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'S&B 500', amount: 1250, interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}

		before(:each) do
			monthly_spending
			savings
			investment
			service.call
			savings.reload
			investment.reload
		end

		it "sets savings to equal six months spending" do
			expect(month.total_savings).to eq month.six_months_spending
		end

		it "transfers the amount over to the investments" do
			expect(investment.amount).to eq 4850.0
		end

		it "has the correct amount of advices" do
			expect(month.advices.length).to eq 1
		end

		it "has the correct advices associated"  do
			advice = month.advices.first
			expect(advice.to).to eq(investment)
			expect(advice.from).to eq(savings)
			expect(advice.amount).to eq(3600.0)
		end
	end

	context "two savings accounts one investment account" do
		let(:savings) { create(:account, a_type:'savings', amount:7000, interest_rate:0.08, name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}
		let(:savings_2) { create(:account, a_type:'savings', amount:8000, interest_rate:0.04, name:'Grandmas Fund', accountable_id: month.id, accountable_type:month.class)}
		let(:investment) { create(:investment, name:'S&B 500', amount: 1250, interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}

		before(:each) do
			monthly_spending
			savings
			savings_2
			investment
			service.call
			savings.reload
			savings_2.reload
			investment.reload
		end

		it "sets savings to equal six months spending" do
			expect(month.total_savings).to eq month.six_months_spending
		end

		it "transfers the amount over to the investments" do
			expect(investment.amount).to eq 4850.0
		end

		it "has the correct amount of advices" do
			expect(month.advices.length).to eq 1
		end

		it "has the correct advices associated"  do
			advice = month.advices.first
			expect(advice.to).to eq(investment)
			expect(advice.from).to eq(savings_2)
			expect(advice.amount).to eq(3600.0)
		end
	end
end
