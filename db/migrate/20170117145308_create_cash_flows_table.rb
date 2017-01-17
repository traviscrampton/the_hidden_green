class CreateCashFlowsTable < ActiveRecord::Migration
  def change
    create_table :cash_flows do |t|
			t.integer :cash_flowable_id
			t.string :cash_flowable_type
			t.float :amount
    end
  end
end
