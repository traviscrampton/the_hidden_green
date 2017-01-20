require 'rails_helper'

RSpec.describe Debts::PayOffSomeDebtFromSavings do

	let(:month) { create(:month) }
	let(:service) { Debts::PayOffSomeDebtFromSavings.new(month)}

	context "has more than three months spending available" do
		let(:debt) { create(:debt, amount: 9000, interest_rate: 0.09, name:'Student Loan', debtable_id: month.id, debtable_type: month.class )}
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
		let(:savings) { create(:account, a_type:"savings", amount: 7000, interest_rate: 0.09, name:'Bank Of America', accountable_type:month.class, accountable_id: month.id)}

		before(:each) do
			debt
			monthly_spending
			savings
		end


		it "keeps savings account above the three_months_spending threshold" do
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

end
