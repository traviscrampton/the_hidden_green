class Month < ActiveRecord::Base

	belongs_to :user
	has_many :debts, as: :debtable
	has_many :accounts, as: :accountable
	has_many :incomes, as: :incomeable
	has_many :debts, as: :debtable
	has_many :investments, as: :investmentable
end
