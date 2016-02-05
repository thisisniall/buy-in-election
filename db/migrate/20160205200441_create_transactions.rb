class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :user
      t.integer :candidate
      t.integer :shares_clinton
      t.integer :shares_sanders
      t.integer :shares_dem_rof
      t.integer :shares_carson
      t.integer :shares_cruz
      t.integer :shares_rubio
      t.integer :shares_trump
      t.integer :shares_rep_rof
      t.decimal :price
      t.integer :type
      t.decimal :total_value

      t.timestamps null: false
    end
  end
end
