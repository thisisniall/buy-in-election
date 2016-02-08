class ChangeColumnNameTransactionsType < ActiveRecord::Migration
  def change
  	rename_column :transactions, :type, :buysell
  end
end
