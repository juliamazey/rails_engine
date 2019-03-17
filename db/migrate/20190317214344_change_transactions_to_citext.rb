class ChangeTransactionsToCitext < ActiveRecord::Migration[5.2]
  def change
    enable_extension('citext')

    change_column :transactions, :result, :citext
  end
end
