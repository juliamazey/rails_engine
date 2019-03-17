class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    limit = params["quantity"].to_i
    render json: MerchantSerializer.new(Merchant.top_by_revenue(limit))
  end

end
