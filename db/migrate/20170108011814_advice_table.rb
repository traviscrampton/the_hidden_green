class AdviceTable < ActiveRecord::Migration
  def change
		create_table :advices do |t|
			t.integer :adviceable_id
			t.integer :adviceable_type
			t.text :description
		end
  end
end
