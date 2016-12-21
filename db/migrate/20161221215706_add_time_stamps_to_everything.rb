class AddTimeStampsToEverything < ActiveRecord::Migration
  def change
	%w{
		accounts
		debts
		monthly_spendings
		incomes
		investments	
	}.each do |table_name|
		add_column(table_name.to_sym, :created_at, :datetime)
		add_column(table_name.to_sym, :updated_at, :datetime)
	end
  end
end
