class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :customer_id, :merchant_id, :status

  has_many :invoice_items
  has_many :transactions

end
