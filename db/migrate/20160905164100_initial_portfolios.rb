class InitialPortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.string :type
      t.integer :amount
      t.float :interest_rate
    end

    create_table :monthly_spendings do |t|
      t.integer :portfolio_id
      t.integer :rent
      t.integer :food
      t.integer :phone
      t.integer :utilities
      t.integer :everything_else
    end

    create_table :monthly_incomes do |t|
      t.integer :user_id
      t.string :source_name
      t.integer :source_amount
    end

    create_table :assets do |t|
      t.integer :user_id
      t.string :name
      t.integer :amount
    end

  end
end
