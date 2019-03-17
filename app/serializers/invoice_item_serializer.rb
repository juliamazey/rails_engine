class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  attribute :unit_price do |object|
    (object.unit_price / 100.0).to_s
  end

end
