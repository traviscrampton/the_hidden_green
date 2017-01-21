require 'rails_helper'

RSpec.describe Debts::PayOffSomeDebtFromSavings do

	let(:month) { create(:month) }
	let(:service) { Debts::PayOffSomeDebtFromSavings.new(month)}
	let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}

	context "one debt and one savings" do
		let(:debt) { create(:debt, amount: 9000, interest_rate: 0.09, name:'Student Loan', debtable_id: month.id, debtable_type: month.class )}
		let(:savings) { create(:account, a_type:"savings", amount: 7000, interest_rate: 0.09, name:'Bank Of America', accountable_type:month.class, accountable_id: month.id)}

		before(:each) do
			debt
			monthly_spending
			savings
		end


		it "keeps savings account at the three_months_spending threshold" do
			service.call
			savings.reload
			expect(savings.amount).to eq month.three_months_spending
		end

		it "pays off part of the debt" do
			service.call
			debt.reload
			expect(debt.amount).to eq 7700.0
		end

		it "adds the proper advices" do
			service.call
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 1300.0 from your Bank Of America account to your Student Loan debt")
		end
	end

	context "has 2 debts and one savings" do
		let(:debt) { create(:debt, amount: 808, interest_rate: 0.09, name:'Credit Card', debtable_id: month.id, debtable_type: month.class )}
		let(:debt_2) { create(:debt, amount: 9000, interest_rate: 0.04, name:'Student Load', debtable_id: month.id, debtable_type: month.class )}
		let(:savings) { create(:account, a_type:"savings", amount: 7000, interest_rate: 0.09, name:'Bank Of America', accountable_type:month.class, accountable_id: month.id)}

		before(:each) do
			monthly_spending
			debt
			debt_2
			savings
		end

		it "keeps savings at the three month threshold" do
			service.call
			savings.reload
			expect(savings.amount).to eq month.three_months_spending
		end

		it "sets debt amount to zero" do
			service.call
			debt.reload
			expect(debt.amount).to eq 0
		end

		it "pays the rest of the savings to debt" do
			service.call
			debt_2.reload
			expect(debt_2.amount).to eq 8508.0
		end

		it "adds the proper advices" do
			service.call
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 808.0 from your Bank Of America account to your Credit Card debt")
			expect(descriptions).to include("Transfer 492.0 from your Bank Of America account to your Student Load debt")
		end
	end
end
