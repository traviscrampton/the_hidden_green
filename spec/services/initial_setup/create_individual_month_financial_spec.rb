require "rails_helper"

RSpec.describe InitialSetup::CreateIndividualMonthFinancials do

	context "user has all financial parameters" do
		let(:user) { create(:user) }
		let(:income) { create(:income, source_name:'careersofia', source_amount: 3200, incomeable_id: user.id, incomeable_type: user.class.name) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: user.id, monthly_spendable_type: user.class.name, rent: 800, phone:100, utilities:50, food: 100, everything_else:100 )}
		let(:debt) { create(:debt, debtable_id: user.id, name:'Student Loans', debtable_type: user.class.name, amount: 8000, interest_rate:0.08, minimum_monthly_payment:120 ) }
		let(:cash_flow) { create(:cash_flow, cash_flowable_id: user.id, cash_flowable_type: user.class.name, amount: 1930)}
		let(:investment) { create(:investment, name:'S&P 500', amount: 1200.0, investmentable_id: user.id, investmentable_type: user.class.name ) }
		let(:months) { InitialSetup::CreateMonths.new(user).call }
		let(:service) { InitialSetup::CreateIndividualMonthFinancials.new(user) }

		before(:each) do
			income
			monthly_spending
			debt
			cash_flow
			investment
			months
			service.call
		end

		it "replicates a users income into a first month" do
			expect(user.months.first.incomes.first.source_amount).to eq(income.source_amount)
			expect(user.months.first.incomes.first.source_name).to eq(income.source_name)
		end

		it "replicates a users monthly_spending into a first month" do
			expect(user.months.first.monthly_spending.rent).to eq(monthly_spending.rent)
			expect(user.months.first.monthly_spending.food).to eq(monthly_spending.food)
			expect(user.months.first.monthly_spending.phone).to eq(monthly_spending.phone)
			expect(user.months.first.monthly_spending.utilities).to eq(monthly_spending.utilities)
			expect(user.months.first.monthly_spending.everything_else).to eq(monthly_spending.everything_else)
		end

		it "replicates a users debt into a first month" do
			expect(user.months.first.debts.first.amount).to eq(debt.amount)
			expect(user.months.first.debts.first.name).to eq(debt.name)
			expect(user.months.first.debts.first.interest_rate).to eq(debt.interest_rate)
			expect(user.months.first.debts.first.minimum_monthly_payment).to eq(debt.minimum_monthly_payment)
		end

		it "replicates a users investment into a first month" do
			expect(user.months.first.investments.first.amount).to eq(investment.amount)
			expect(user.months.first.investments.first.name).to eq(investment.name)
			expect(user.months.first.investments.first.interest_rate).to eq(investment.interest_rate)
		end

		it "replicates a users cash_flow into a first month" do
			expect(user.months.first.cash_flow.amount).to eq(cash_flow.amount)
		end


	end

end
