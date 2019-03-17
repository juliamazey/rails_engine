class ChangeTransactionsBack < ActiveRecord::Migration[5.2]
  def change

    change_column :transactions, :result, 'integer USING CAST(result AS integer)'
  end
end
