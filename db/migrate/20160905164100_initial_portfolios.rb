class InitialPortfolios < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :a_type
      t.float :amount
      t.float :interest_rate
    end

    create_table :investments do |t|
      t.string :name
      t.integer :user_id
      t.float :amount
      t.float :interest_rate
    end

    create_table :debts do |t|
      t.string :name
      t.integer :user_id
      t.float :amount
      t.float :interest_rate
      t.float :minimum_monthly_payment
    end

    create_table :monthly_spendings do |t|
      t.integer :user_id
      t.float :rent
      t.float :food
      t.float :phone
      t.float :utilities
      t.float :everything_else
    end

    create_table :monthly_incomes do |t|
      t.integer :user_id
      t.string :source_name
      t.float :source_amount
    end

    create_table :assets do |t|
      t.integer :user_id
      t.string :name
      t.float :amount
    end

  end
end
