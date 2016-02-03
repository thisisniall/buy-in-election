class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :fname
      t.string :lname
      t.integer :party
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
