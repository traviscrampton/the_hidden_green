require 'rails_helper'

RSpec.describe Debts::PayOffAllDebtFromSavings do
	let(:month) {create(:month)}
	let(:service) { Debts::PayOffAllDebtFromSavings.new(month) }

	context "one debt acount, one savings account" do
		let(:debt) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Student Loan', interest_rate: 0.08, amount: 8000.0, minimum_monthly_payment: 120.0)}
		let(:savings) { create(:account, amount: 35000, interest_rate:0.09, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}

		before(:each) do
			debt
			savings
			service.call
			debt.reload
			savings.reload
		end

		it "pays off all debt and makes debt amount equal to zero" do
			expect(debt.amount).to eq 0
		end
		it "subtracts the correct amount from the account" do
			expect(savings.amount).to eq 27000
		end

		it "adds the proper advice for this context" do
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include("Transfer 8000.0 from your Bank Of America account to your Student Loan debt")
		end
	end

	context "Multiple Debts with one savings account" do
		let(:debt_1) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Student Loan', interest_rate: 0.08, amount: 4255.0, minimum_monthly_payment: 120.0)}
		let(:debt_2) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Credit Card', interest_rate: 0.08, amount: 1029.0, minimum_monthly_payment: 120.0)}
		let(:savings) { create(:account, amount: 35000, interest_rate:0.09, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}

		before(:each) do
			debt_1
			debt_2
			savings
			service.call
			debt_1.reload
			debt_2.reload
			savings.reload
		end

		it "Pays off both debts to zero" do
			expect(debt_1.amount).to eq 0
			expect(debt_2.amount).to eq 0
		end

		it "Subtracts the proper amount from savings" do
			expect(savings.amount).to eq 29716
		end

		it "adds the proper advice for the context" do
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include "Transfer 4255.0 from your Bank Of America account to your Student Loan debt"
			expect(descriptions).to include "Transfer 1029.0 from your Bank Of America account to your Credit Card debt"
		end
	end

	context "Multiple Savings Accounts and One Debt" do
		let(:savings_1) { create(:account, amount: 35000, interest_rate:0.09, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}
		let(:savings_2) { create(:account, amount: 5000, interest_rate:0.07, a_type:'savings', name:'Grandmas Fund', accountable_id: month.id, accountable_type:month.class)}
		let(:debt) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Student Loan', interest_rate: 0.08, amount: 8000.0, minimum_monthly_payment: 120.0)}

		before(:each) do
			savings_1
			savings_2
			debt
			service.call
			savings_1.reload
			savings_2.reload
			debt.reload
		end

		it "pays off debt completely" do
			expect(debt.amount).to eq 0
		end

		it "takes away the whole amount from the first savings" do
			expect(savings_2.amount).to eq 0
		end

		it "takes away the remainder from the second account" do
			expect(savings_1.amount).to eq 32000
		end

		it "adds the proper advice given the context" do
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include "Transfer 5000.0 from your Grandmas Fund towards your Student Loan debt"
			expect(descriptions).to include "Transfer 3000.0 from your Bank Of America account to your Student Loan debt"
		end
	end

	context "two savings accounts and two debt accounts" do
		let(:savings_1) { create(:account, amount: 5000, interest_rate:0.07, a_type:'savings', name:'Grandmas Fund', accountable_id: month.id, accountable_type:month.class)}
		let(:savings_2) { create(:account, amount: 35000, interest_rate:0.09, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class)}
		let(:debt_1) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Student Loan', interest_rate: 0.08, amount: 8000.0, minimum_monthly_payment: 120.0)}
		let(:debt_2) { create(:debt, debtable_id: month.id, debtable_type: month.class, name:'Credit Card', interest_rate: 0.10, amount: 1029.0, minimum_monthly_payment: 120.0)}

		before(:each) do
			savings_1
			savings_2
			debt_1
			debt_2
			service.call
			savings_1.reload
			savings_2.reload
			debt_1.reload
			debt_2.reload
		end

		it "sets the first debt amount equal to zero" do
			expect(debt_1.amount).to eq 0
		end

		it "sets the second debt equal to zero" do
			service.call
			debt_2.reload
			expect(debt_2.amount).to eq 0
		end

		it "subtracts the proper amount from the first savings" do
			expect(savings_1.amount).to eq 0
		end

		it "subtracts the proper amount from the other savings account" do
			expect(savings_2.amount).to eq 30971.0

		end

		it "creates the proper advices based on the context" do
			descriptions = month.advices.pluck(:description)
			expect(descriptions).to include "Transfer 1029.0 from your Grandmas Fund account to your Credit Card debt"
			expect(descriptions).to include "Transfer 3971.0 from your Grandmas Fund towards your Student Loan debt"
			expect(descriptions).to include "Transfer 4029.0 from your Bank Of America account to your Student Loan debt"
		end
	end
end
