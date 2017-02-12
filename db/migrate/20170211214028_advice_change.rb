class AdviceChange < ActiveRecord::Migration
  def change
		add_column :advices, :to_type, :string
		add_column :advices, :to_id, :integer
		add_column :advices, :from_type, :string
		add_column :advices, :from_id, :integer
		add_column :advices, :amount, :float
		remove_column :advices, :description
  end
end
