class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :result

  attribute :credit_card_number do |object|
    object.credit_card_number.to_s
  end

end
