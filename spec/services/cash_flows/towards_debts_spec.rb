require 'rails_helper'

RSpec.describe CashFlows::TowardsDebts do
	let(:month) { create(:month) }
	let(:service) { CashFlows::TowardsDebts.new(month) }

	context "single debt" do
		let(:debt) { create(:debt, name:'Credit Card', amount: 1500.0, interest_rate: 0.12, debtable_id: month.id, debtable_type:month.class)}
		context "has enough cash flow to pay off debt" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type:month.class, amount: 2000 )}

			before(:each) do
				cash_flow
				debt
				service.call
				debt.reload
				cash_flow.reload
			end

			it 'pays off all the debt' do
				expect(debt.amount).to eq 0
			end

			it 'subtracts properly from the cash flow' do
				expect(cash_flow.amount).to eq 500.0
			end

			it 'has proper number of advices' do
				expect(month.advices.length).to eq 1
			end

			it 'has the proper advice' do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 1500.0 should go towards Credit Card debt")
			end
		end

		context "does not have enough cash flow to pay off debt" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type:month.class, amount: 500 )}

			before(:each) do
				cash_flow
				debt
				service.call
				debt.reload
				cash_flow.reload
			end

			it 'sets cash flow eq 0' do
				expect(cash_flow.amount).to eq 0
			end

			it 'pays off part of the debt' do
				expect(debt.amount).to eq 1000.0
			end


			it 'has proper number of advices' do
				expect(month.advices.length).to eq 1
			end

			it 'has the proper advice' do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 500.0 should go towards Credit Card debt")
			end
		end
	end

	context "multiple debts" do
		let(:debt) { create(:debt, name:'Credit Card', amount: 1000.0, interest_rate: 0.12, debtable_id: month.id, debtable_type:month.class)}
		let(:debt_2) { create(:debt, name:'Student Loan', amount: 1500.0, interest_rate: 0.02, debtable_id: month.id, debtable_type:month.class)}

		context "has enough cash flow to pay off both debts" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type:month.class, amount: 3000 )}

			before(:each) do
				debt
				debt_2
				cash_flow
				service.call
				cash_flow.reload
				debt.reload
				debt_2.reload
			end

			it "sets the first debt to zero" do
				expect(debt.amount).to eq 0
			end

			it "sets the second debt to zero" do
				expect(debt_2.amount).to eq 0
			end

			it "sets the cash flow to the proper amount" do
				expect(cash_flow.amount).to eq 500.0
			end

			it "has the proper amount of advices" do
				expect(month.advices.length).to eq 2
			end

			it "has the proper advice part 1" do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 1500.0 should go towards Student Loan debt")
			end

			it 'has the proper advice part 2' do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 1000.0 should go towards Credit Card debt")
			end
		end

		context "has enough cash flow to pay off one of the debts" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type:month.class, amount: 2000 )}

			before(:each) do
				debt
				debt_2
				cash_flow
				service.call
				cash_flow.reload
				debt.reload
				debt_2.reload
			end

			it "pays off first debt" do
				expect(debt.amount).to eq 0
			end

			it "can't pay off one of the debts completely" do
				expect(debt_2.amount).to eq 500.0
			end

			it "sets cash flow equal to zero" do
				expect(month.cash_flow.amount).to eq 0
			end

			it "has the proper number of advices" do
				expect(month.advices.length).to eq 2
			end

			it "has the proper advice part 1" do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 1000.0 should go towards Credit Card debt")
			end

			it "has the proper advices part 2" do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 1000.0 should go towards Student Loan debt")
			end
		end

		context "does not have cash flow to pay either debts" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type:month.class, amount: 500 )}

			before(:each) do
				debt
				debt_2
				cash_flow
				service.call
				cash_flow.reload
				debt.reload
				debt_2.reload
			end

			it "sets cash flow equal to zero" do
				expect(cash_flow.amount).to eq 0
			end

			it "pays off some of the first debt" do
				expect(debt.amount).to eq 500.0
			end

			it "doesn't pay off any of the second debt" do
				expect(debt_2.amount).to eq 1500.0
			end

			it 'has the proper amount of advices' do
				expect(month.advices.length).to eq 1
			end

			it 'has the proper advice included' do
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Cash flow of 500.0 should go towards Credit Card debt")
			end
		end
	end
end
