class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    id = params["merchant_id"]
    invoices = Merchant.find(id).invoices
    render json: InvoiceSerializer.new(invoices)
  end

end
