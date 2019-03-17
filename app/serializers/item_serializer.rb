class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id, :name, :description, :unit_price

  has_many :invoice_items
end
