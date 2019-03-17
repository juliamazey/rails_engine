class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    limit = params["quantity"].to_i
    render json: MerchantSerializer.new(Merchant.top_by_items_sold(limit))
  end

end
