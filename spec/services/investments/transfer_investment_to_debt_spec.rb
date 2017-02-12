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
				service.call
			end

			it "sets the debt equal to zero" do
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "subtracts the proper amount from investment" do
				investment.reload
				expect(investment.amount).to eq 2000
			end

			it "gives the proper advice" do
				advice = month.advices.first
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(3000.0)
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
				service.call
			end

			it "makes debt equal to zero" do
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "makes debt_2 equal to zero" do
				debt_2.reload
				expect(debt_2.amount).to eq 0
			end

			it 'subtracts properly from the investment' do
				investment.reload
				expect(investment.amount).to eq 3457.0
			end

			it "gives the correct advice for debt_1" do
				advice = month.advices.second
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(3000.0)
			end

			it "gives the correct advice for debt_2" do
				advice = month.advices.first
				expect(advice.to).to eq(debt_2)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(8543.0)
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
				service.call
			end

			it "pays off all the debt" do
				service.call
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "sets the first investment to zero" do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "subtracts the right amount from the investment" do
				investment_2.reload
				expect(investment_2.amount).to eq 2457.0
			end

			it "adds the proper advice part 1" do
				advice = month.advices.first
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(5000.0)
			end

			it "adds the proper advice part 2" do
				advice = month.advices.second
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment_2)
				expect(advice.amount).to eq(3543.0)
			end
		end

		context "two debts and two investments" do
			let(:investment) { create(:investment, amount: 5000, name:'Big Stock Investment', interest_rate: 0.05, investmentable_id: month.id, investmentable_type:month.class )}
			let(:investment_2) { create(:investment, amount: 6000, name:'S&B 500', interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}
			let(:debt) { create(:debt, amount: 8543, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.09 )}
			let(:debt_2) { create(:debt, amount: 1540, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}

			before(:each) do
				investment
				investment_2
				debt
				debt_2
				service.call
			end

			it "sets first debt equal to zero" do
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "sets second debt equal to zero" do
				debt_2.reload
				expect(debt_2.amount).to eq 0
			end

			it "subtracts the right amount from first investment" do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "subtracts the right amount from the second investment" do
				investment_2.reload
				expect(investment_2.amount).to eq 917.0
			end

			it "adds the correct advices part 1" do
				advice = month.advices.first
				expect(advice.to).to eq(debt_2)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(1540.0)
			end

			it "adds the correct advices part 2" do
				advice = month.advices.second
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(3460.0)
			end

			it "adds the correct advices part 3" do
				advice = month.advices.third
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment_2)
				expect(advice.amount).to eq(5083.0)
			end

			it "has three advices" do
				expect(month.advices.length).to eq 3
			end
		end
	end

	context "Total Debt is greater than total investment" do
		context "one debt, one investment" do
			let(:debt) { create(:debt, amount: 5000, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.08 )}
			let(:investment) { create(:investment, amount: 3000, name:'Big Stock Investment', interest_rate: 0.09, investmentable_id: month.id, investmentable_type:month.class )}

			before(:each) do
				debt
				investment
				service.call
			end

			it "sets the investment equal to zero" do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "subtracts the proper amount from debt" do
				debt.reload
				expect(debt.amount).to eq 2000
			end

			it "gives the proper advice" do
				advice = month.advices.first
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(3000.0)
			end
		end

		context "two debts, one investment" do
			let(:debt) { create(:debt, amount: 3000, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}
			let(:debt_2) { create(:debt, amount: 8543, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.08 )}
			let(:investment) { create(:investment, amount: 11000, name:'Big Stock Investment', interest_rate: 0.09, investmentable_id: month.id, investmentable_type:month.class )}

			before(:each) do
				debt
				debt_2
				investment
				service.call
			end

			it "pays off one debt" do
				debt.reload
				expect(debt.amount).to eq 0
			end

			it "pays as much as they can on second debt" do
				debt_2.reload
				expect(debt_2.amount).to eq 543
			end

			it 'takes investment all the way to zero' do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "gives the correct advice for debt_1" do
				advice = month.advices.first
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(3000.0)
			end

			it "gives the correct advice for debt_2" do
				advice = month.advices.second
				expect(advice.to).to eq(debt_2)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(8000.0)
			end
		end

		context "one debt, two investments" do
			let(:debt) { create(:debt, amount: 12000, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}
			let(:investment) { create(:investment, amount: 5000, name:'Big Stock Investment', interest_rate: 0.05, investmentable_id: month.id, investmentable_type:month.class )}
			let(:investment_2) { create(:investment, amount: 6000, name:'S&B 500', interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}

			before(:each) do
				debt
				investment
				investment_2
				service.call
			end

			it "pays off most of the debt" do
				debt.reload
				expect(debt.amount).to eq 1000
			end

			it "sets the first investment to zero" do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "sets the second investment equal to zero" do
				investment_2.reload
				expect(investment_2.amount).to eq 0
			end

			it "adds the proper advice part 1" do
				advice = month.advices.first
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(5000.0)
			end

			it "adds the proper advice part 2" do
				advice = month.advices.second
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment_2)
				expect(advice.amount).to eq(6000.0)
			end
		end

		context "two debts and two investments" do
			let(:investment) { create(:investment, amount: 5000, name:'Big Stock Investment', interest_rate: 0.05, investmentable_id: month.id, investmentable_type:month.class )}
			let(:investment_2) { create(:investment, amount: 6000, name:'S&B 500', interest_rate: 0.07, investmentable_id: month.id, investmentable_type:month.class )}
			let(:debt) { create(:debt, amount: 8543, name:'Student Loan', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.09 )}
			let(:debt_2) { create(:debt, amount: 4540, name:'Credit Card', debtable_id: month.id, debtable_type: month.class, interest_rate: 0.10 )}

			before(:each) do
				investment
				investment_2
				debt
				debt_2
				service.call
			end

			it "sets first debt equal to zero" do
				debt.reload
				expect(debt.amount).to eq 2083.0
			end

			it "pays off part of the second debt" do
				debt_2.reload
				expect(debt_2.amount).to eq 0
			end

			it "sets the first investment equal to zero" do
				investment.reload
				expect(investment.amount).to eq 0
			end

			it "sets the second investment equal to zero" do
				investment_2.reload
				expect(investment_2.amount).to eq 0
			end

			it "adds the correct advices part 1" do
				advice = month.advices.first
				expect(advice.to).to eq(debt_2)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(4540.0)
			end

			it "adds the correct advices part 2" do
				advice = month.advices.second
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment)
				expect(advice.amount).to eq(460.0)
			end

			it "adds the correct advices part 3" do
				advice = month.advices.third
				expect(advice.to).to eq(debt)
				expect(advice.from).to eq(investment_2)
				expect(advice.amount).to eq(6000.0)
			end

			it "has three advices" do
				expect(month.advices.length).to eq 3
			end
		end
	end
end
