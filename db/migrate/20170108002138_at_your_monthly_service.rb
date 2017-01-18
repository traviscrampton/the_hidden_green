class AtYourMonthlyService < ActiveRecord::Migration
  def change
		create_table :months do |t|
			t.integer :user_id
			t.string :name
			t.integer :sequence_num
			t.integer :year
		end

		add_column :debts, :debtable_type, :string
		add_column :accounts, :accountable_type, :string
		add_column :investments, :investmentable_type, :string
		add_column :incomes, :incomeable_type, :string
		add_column :monthly_spendings, :monthly_spendable_type, :string

		rename_column :debts, :user_id, :debtable_id
		rename_column :accounts, :user_id, :accountable_id
		rename_column :investments, :user_id, :investmentable_id
		rename_column :incomes, :user_id, :incomeable_id
		rename_column :monthly_spendings, :user_id, :monthly_spendable_id
  end
end
