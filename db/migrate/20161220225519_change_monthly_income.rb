class ChangeMonthlyIncome < ActiveRecord::Migration
  def change
		rename_table :monthly_incomes, :incomes
  end
end
