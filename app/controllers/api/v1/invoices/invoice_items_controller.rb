class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    id = params["invoice_id"].to_i
    invoice_items = Invoice.find(id).invoice_items
    render json: InvoiceItemSerializer.new(invoice_items)
  end

end
