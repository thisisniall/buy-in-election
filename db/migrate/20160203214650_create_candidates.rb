class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :party
      t.float :iowa_average
      t.float :iowa_bid
      t.float :iowa_ask
      t.float :iowa_high
      t.float :iowa_low
      t.integer :twitter_pos
      t.integer :twitter_neg
      t.integer :twitter_tot

      t.timestamps null: false
    end
  end
end
