class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :fname
      t.string :lname
      t.integer :party
      t.decimal :money
      t.integer :shares_clinton
      t.integer :shares_sanders
      t.integer :shares_dem_rof
      t.integer :shares_carson
      t.integer :shares_cruz
      t.integer :shares_rubio
      t.integer :shares_trump
      t.integer :shares_rep_rof
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
