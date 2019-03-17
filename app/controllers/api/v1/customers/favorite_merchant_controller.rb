class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    id = params["id"].to_i
    render json: MerchantSerializer.new(Merchant.favorite_merchant(id))
  end

end
