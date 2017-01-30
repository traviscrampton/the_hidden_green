require 'rails_helper'

RSpec.describe FinancialForcast::FutureMonths do

	let(:user) { create(:user) }
	let(:create_months_service) { InitialSetup::CreateMonths.new(user).call }
	let(:first_month_financial){ InitialSetup::CreateIndividualMonthFinancials.new(user).call }
	let(:month) { user.months.first }
	let(:service) { FinancialForcast::FutureMonths.new(month)}

	context "passes in first month" do
		let(:investment) { create(:investment, investmentable_id: user.id, investmentable_type: user.class, amount: 0, interest_rate:0.09, name:'S&B 5000')}
		let(:account) { create(:account, a_type:'savings', amount: 0, interest_rate:0.03, name:'Bank Of America', accountable_type: user.class, accountable_id: user.id)}
		let(:debt) { create(:debt, amount: 0, interest_rate: 0.04, name:"Student Loan", debtable_id: user.id, debtable_type: user.class, minimum_monthly_payment: 0) }
		let(:monthly_spending) { create(:monthly_spending, monthly_spendable_id: user.id, monthly_spendable_type:user.class, food: 100, phone: 100, rent: 800, utilities: 50, everything_else: 850)}
		let(:income) { create(:income, source_amount: 3200, incomeable_id: user.id, incomeable_type:user.class) }
		let(:cash_flow) { create(:cash_flow, cash_flowable_id: user.id, cash_flowable_type: user.class, amount: 1500)}

		before(:each) do
			user
			investment
			account
			debt
			monthly_spending
			income
			cash_flow
			create_months_service
			first_month_financial
			service.call
		end

		# first months specs
		it "proper debt number for first month" do
			month = user.months.first
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.first
			expect(month.total_savings).to eq 1500
		end

		it "proper investment for first month" do
			month = user.months.first
			expect(month.total_investment).to eq 0
		end

		# Second months specs
		it "proper debt number for second month" do
			month = user.months.second
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for second month" do
			month = user.months.second
			expect(month.total_savings).to eq 3000
		end

		it "proper investment for second month" do
			month = user.months.second
			expect(month.total_investment).to eq 0
		end

		# Third months specs
		it "proper debt number for third month" do
			month = user.months.third
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for third month" do
			month = user.months.third
			expect(month.total_savings).to eq 4500
		end

		it "proper investment for third month" do
			month = user.months.third
			expect(month.total_investment).to eq 0
		end

		# Fourth months specs
		it "proper debt number for fourth month" do
			month = user.months.fourth
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for fourth month" do
			month = user.months.fourth
			expect(month.total_savings).to eq 6000
		end

		it "proper investment for fourth month" do
			month = user.months.fourth
			expect(month.total_investment).to eq 0
		end

		# Fifth months specs
		it "proper debt number for fifth month" do
			month = user.months.fifth
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for fifth month" do
			month = user.months.fifth
			expect(month.total_savings).to eq 7500
		end

		it "proper investment for fifth month" do
			month = user.months.fifth
			expect(month.total_investment).to eq 0
		end

		# Sixth months specs
		it "proper debt number for fifth month" do
			month = user.months.at(5)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for sixth month" do
			month = user.months.at(5)
			expect(month.total_savings).to eq 9000
		end

		it "proper investment for sixth month" do
			month = user.months.at(5)
			expect(month.total_investment).to eq 0
		end

		# Seventh months specs
		it "proper debt number for sixth month" do
			month = user.months.at(6)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for seventh month" do
			month = user.months.at(6)
			expect(month.total_savings).to eq 10500
		end

		it "proper investment for seventh month" do
			month = user.months.at(6)
			expect(month.total_investment).to eq 0
		end

		# Eighth months specs
		it "proper debt number for eight month" do
			month = user.months.at(7)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for eight month" do
			month = user.months.at(7)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for eighth month" do
			month = user.months.at(7)
			expect(month.total_investment).to eq 600
		end

		# Ninth months specs
		it "proper debt number for first month" do
			month = user.months.at(8)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.at(8)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for first month" do
			month = user.months.at(8)
			expect(month.total_investment).to eq 2100
		end

		# Tenth months specs
		it "proper debt number for first month" do
			month = user.months.at(9)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.at(9)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for first month" do
			month = user.months.at(9)
			expect(month.total_investment).to eq 3600
		end

		# Eleventh months specs
		it "proper debt number for first month" do
			month = user.months.at(10)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.at(10)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for first month" do
			month = user.months.at(10)
			expect(month.total_investment).to eq 5100
		end

		# 12th months specs
		it "proper debt number for first month" do
			month = user.months.at(11)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.at(11)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for first month" do
			month = user.months.at(11)
			expect(month.total_investment).to eq 6600
		end

		# 13th months specs
		it "proper debt number for first month" do
			month = user.months.at(12)
			expect(month.total_debt).to eq 0
		end

		it "proper savings amount for first month" do
			month = user.months.at(12)
			expect(month.total_savings).to eq 11400
		end

		it "proper investment for first month" do
			month = user.months.at(12)
			expect(month.total_investment).to eq 8100
		end
	end
end
