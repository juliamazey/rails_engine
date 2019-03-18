class ChangeInvoicesToCitext < ActiveRecord::Migration[5.2]
  def change
    enable_extension('citext')

    change_column :invoices, :status, :citext
  end
end
