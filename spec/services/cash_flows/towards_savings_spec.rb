require "rails_helper"

RSpec.describe CashFlows::TowardsSavings do
	let(:month) { create(:month) }
	let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: month.id, monthly_spendable_type:month.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
	let(:service) { CashFlows::TowardsSavings.new(month) }

	context "no debt" do
		context "cash flow is less than whats required to get to six months spending" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 2000) }
			let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class, amount: 8000, interest_rate:0.08 )}

			before(:each) do
				monthly_spending
				cash_flow
				savings
				service.call
				cash_flow.reload
				savings.reload
			end

			it "sets cash_flow for the month equal to zero" do
				expect(month.cash_flow.amount).to eq 0
			end

			it "adds the cash flow towards the savings" do
				expect(savings.amount).to eq 10000
			end

			it "has an advice length of 1" do
				expect(month.advices.length).to eq 1
			end

			it "has the proper advice" do
				advice = month.advices.first
				expect(advice.to).to eq(savings)
				expect(advice.from).to eq(cash_flow)
				expect(advice.amount).to eq(2000.0)
			end
		end

		context "cash flow is more than whats required to get to six months spending" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 2000)}
			let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class, amount: 10000, interest_rate:0.08 )}

			before(:each) do
				monthly_spending
				cash_flow
				savings
				service.call
				cash_flow.reload
				savings.reload
			end

			it "sets the proper cash flow" do
				expect(month.cash_flow.amount).to eq 600
			end

			it "adds the cash flow towards the savings" do
				expect(savings.amount).to eq 11400
			end

			it "has an advice length of 1" do
				expect(month.advices.length).to eq 1
			end

			it "has the proper advices" do
				advice = month.advices.first
				expect(advice.to).to eq(savings)
				expect(advice.from).to eq(cash_flow)
				expect(advice.amount).to eq(1400)
			end
		end
	end

	context "has debt" do
		let(:debt) { create(:debt, debtable_id: month.id, debtable_type:month.class, amount: 1, interest_rate:0.09, name:'Student Loan')}

		context "cash flow is less than whats required to get to six months spending" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 2000) }
			let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class, amount: 2000, interest_rate:0.08 )}
			before(:each) do
				monthly_spending
				debt
				cash_flow
				savings
				service.call
				cash_flow.reload
				savings.reload
			end

			it "sets cash_flow for the month equal to zero" do
				expect(month.cash_flow.amount).to eq 0
			end

			it "adds the cash flow towards the savings" do
				expect(savings.amount).to eq 4000
			end

			it "has an advice length of 1" do
				expect(month.advices.length).to eq 1
			end

			it "has the proper advice" do
				advice = month.advices.first
				expect(advice.to).to eq(savings)
				expect(advice.from).to eq(cash_flow)
				expect(advice.amount).to eq(2000.0)
			end
		end

		context "cash flow is more than whats required to get to six months spending" do
			let(:cash_flow) { create(:cash_flow, cash_flowable_id: month.id, cash_flowable_type: month.class, amount: 2000)}
			let(:savings) { create(:account, a_type:'savings', name:'Bank Of America', accountable_id: month.id, accountable_type:month.class, amount: 5000, interest_rate:0.08 )}

			before(:each) do
				monthly_spending
				debt
				cash_flow
				savings
				service.call
				cash_flow.reload
				savings.reload
			end

			it "sets the proper cash flow" do
				expect(month.cash_flow.amount).to eq 1300
			end

			it "adds the cash flow towards the savings" do
				expect(savings.amount).to eq month.three_months_spending
			end

			it "has an advice length of 1" do
				expect(month.advices.length).to eq 1
			end

			it "has the proper advices" do
				advice = month.advices.first
				expect(advice.to).to eq(savings)
				expect(advice.from).to eq(cash_flow)
				expect(advice.amount).to eq(700.0)
			end
		end
	end
end
