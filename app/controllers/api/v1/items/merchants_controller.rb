class Api::V1::Items::MerchantsController < ApplicationController

  def show
    id = params["item_id"].to_i
    merchant = Item.find(id).merchant
    render json: MerchantSerializer.new(merchant)
  end

end
