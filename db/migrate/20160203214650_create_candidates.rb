class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :party
      t.decimal :iowa_value
      t.integer :total_shares
      t.integer :twitter_pos
      t.integer :twitter_neg
      t.integer :twitter_tot

      t.timestamps null: false
    end
  end
end
