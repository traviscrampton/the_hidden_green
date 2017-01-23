require 'rails_helper'


RSpec.describe FinancialForcast::CalculationMatrix do
	let(:month) { create(:month) }
	let(:service) { FinancialForcast::CalculationMatrix.new(month)}

	context "standard trav scenario" do
		let(:investment) { create(:investment, investmentable_id: month.id, investmentable_type: month.class, amount: 0, interest_rate:0.09, name:'S&B 5000')}
		let(:account) { create(:account, a_type:'savings', amount: 35000, interest_rate:0.03, name:'Bank Of America', accountable_type: month.class, accountable_id: month.id)}
		let(:debt) { create(:debt, amount: 8000.0, interest_rate: 0.04, name:"Student Loan", debtable_id: month.id, debtable_type: month.class, minimum_monthly_payment: 100) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
		let(:income) { create(:income, source_amount: 3200, incomeable_id: month.id, incomeable_type:month.class) }
		let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class)}

		before(:each) do
			investment
			account
			debt
			monthly_spending
			income
			cash_flow
			service.call
			investment.reload
			account.reload
			debt.reload
			cash_flow.reload
		end

		it "pays off debt with savings" do
			expect(debt.amount).to eq 0
		end

		it "sets savings equal to six months spending" do
			expect(account.amount).to eq 11400.0
		end

		it "puts the rest of the savings plus next months cash flow towards investment" do
			expect(investment.amount).to eq 15600.0
		end

		it "should use all of the cash flow before the end" do
			expect(cash_flow).to eq 0
		end

		it "has the proper number of advices" do
			expect(month.advices.length).to eq 4
		end
	end

	context "somebody who doesn't yet have three months spending with investment" do
		let(:investment) { create(:investment, investmentable_id: month.id, investmentable_type: month.class, amount: 1000, interest_rate:0.09, name:'S&B 5000')}
		let(:account) { create(:account, a_type:'savings', amount: 4700, interest_rate:0.03, name:'Bank Of America', accountable_type: month.class, accountable_id: month.id)}
		let(:debt) { create(:debt, amount: 8000.0, interest_rate: 0.04, name:"Student Loan", debtable_id: month.id, debtable_type: month.class, minimum_monthly_payment: 100) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
		let(:income) { create(:income, source_amount: 3200, incomeable_id: month.id, incomeable_type:month.class) }
		let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 1300.0)}

		before(:each) do
			investment
			account
			debt
			monthly_spending
			income
			cash_flow
			service.call
			investment.reload
			account.reload
			account.reload
			debt.reload
			cash_flow.reload
		end

		it "pays off debt with current months cash flow" do
			expect(debt.amount).to eq 6700.0
		end

		it "transfers everything from investment" do
			expect(investment.amount).to eq 0
		end

		it "gets the savings to three months spending" do
			expect(account.amount).to eq month.three_months_spending
		end

		it "sets the cash flow equal to zero" do
			expect(cash_flow.amount).to eq 0
		end

		it "has the proper amount of advices" do
			expect(month.advices.length).to eq 2
		end
	end

	context "needs to get to three months, has more investment" do
		let(:investment) { create(:investment, investmentable_id: month.id, investmentable_type: month.class, amount: 4000, interest_rate:0.09, name:'S&B 5000')}
		let(:account) { create(:account, a_type:'savings', amount: 4700, interest_rate:0.03, name:'Bank Of America', accountable_type: month.class, accountable_id: month.id)}
		let(:debt) { create(:debt, amount: 8000.0, interest_rate: 0.04, name:"Student Loan", debtable_id: month.id, debtable_type: month.class, minimum_monthly_payment: 100) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
		let(:income) { create(:income, source_amount: 3200, incomeable_id: month.id, incomeable_type:month.class) }
		let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 1300.0)}

		before(:each) do
			investment
			account
			debt
			monthly_spending
			income
			cash_flow
			service.call
			investment.reload
			account.reload
			account.reload
			debt.reload
			cash_flow.reload
		end

		it "pays off debt with current months cash flow" do
			expect(debt.amount).to eq 3700.0
		end

		it "transfers everything from investment" do
			expect(investment.amount).to eq 0
		end

		it "gets the savings to three months spending" do
			expect(account.amount).to eq month.three_months_spending
		end

		it "sets the cash flow equal to zero" do
			expect(cash_flow.amount).to eq 0
		end

		it "has the proper amount of advices" do
			expect(month.advices.length).to eq 3
		end
	end
end
