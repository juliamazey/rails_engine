class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    id = params["invoice_id"].to_i
    items = Invoice.find(id).items
    render json: ItemSerializer.new(items)
  end

end
