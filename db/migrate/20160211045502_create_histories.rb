class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :candidate
      t.integer :units
      t.decimal :volume
      t.decimal :low
      t.decimal :high
      t.decimal :average
      t.decimal :last
      t.datetime :date
      
      t.timestamps null: false
    end
  end
end
