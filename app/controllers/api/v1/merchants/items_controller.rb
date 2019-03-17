class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    id = params["merchant_id"]
    items = Merchant.find(id).items
    render json: ItemSerializer.new(items)
  end

end
