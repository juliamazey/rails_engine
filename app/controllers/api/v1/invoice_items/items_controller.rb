class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    id = params["invoice_item_id"].to_i
    item = InvoiceItem.find(id).item
    render json: ItemSerializer.new(item)
  end

end
