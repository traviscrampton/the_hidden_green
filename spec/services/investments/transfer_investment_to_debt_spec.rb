require 'rails_helper'

RSpec.describe Investments::TransferInvestmentToDebt do

	let(:month) { create(:month) }
	let(:service) { Investments::TransferInvestmentToDebt.new(month) }


	context "Enough investment to pay off everything" do
		context "one debt, one investment" do
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
				expect(descriptions).to include("Transfer 3000.0 from your Big Stock Investment investment to your Student Loan debt")
			end
		end

		context "two debts, one investment" do
			let(:debt) { create(:debt, amount: 3000, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.08 )}
			let(:debt_2) { create(:debt, amount: 8543, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}
			let(:investment) { create(:investment, amount: 15000, name:'Big Stock Investment', interest_rate: 0.09, investmentable_id: month.id, investmentable_type:month.class )}

			before(:each) do
				debt
				debt_2
				investment
			end

			it "makes debt equal to zero" do
				service.call
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "makes debt_2 equal to zero" do
				service.call
				debt_2.reload
				expect(debt_2.amount).to eq 0
			end

			it 'subtracts properly from the investment' do
				service.call
				investment.reload
				expect(investment.amount).to eq 3457.0
			end

			it "gives the correct advice for debt_1" do
				service.call
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Transfer 3000.0 from your Big Stock Investment investment to your Student Loan debt")
			end

			it "gives the correct advice for debt_2" do
				service.call
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Transfer 8543.0 from your Big Stock Investment investment to your Credit Card debt")
			end
		end

		context "one debt, two investments" do
			let(:debt) { create(:debt, amount: 8543, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}
			let(:investment) { create(:investment, amount: 5000, name:'Big Stock Investment', interest_rate: 0.05, investmentable_id: month.id, investmentable_type:month.class )}
			let(:investment_2) { create(:investment, amount: 6000, name:'S&B 500', interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}

			before(:each) do
				debt
				investment
				investment_2
			end

			it "pays off all the debt" do
				service.call
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "sets the first investment to zero" do
				service.call
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "subtracts the right amount from the investment" do
				service.call
				investment_2.reload
				expect(investment_2.amount).to eq 2457.0
			end

			it "adds the proper advice part 1" do
				service.call
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Transfer 5000.0 from your Big Stock Investment investment to your Credit Card debt")
			end

			it "adds the proper advice part 2" do
				service.call
				descriptions = month.advices.pluck(:description)
				expect(descriptions).to include("Transfer 3543.0 from your S&B 500 investment to your Credit Card debt")
			end
		end

	end

end
