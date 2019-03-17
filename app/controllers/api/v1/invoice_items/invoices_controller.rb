class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    id = params["invoice_item_id"].to_i
    invoice = InvoiceItem.find(id).invoice
    render json: InvoiceSerializer.new(invoice)
  end

end
