class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    id = params["item_id"].to_i
    invoice_items = Item.find(id).invoice_items
    render json: InvoiceItemSerializer.new(invoice_items)
  end

end
