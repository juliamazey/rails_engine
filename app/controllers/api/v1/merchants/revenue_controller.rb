class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchant = Merchant.find(params["merchant_id"])
    if params[:date]
      date = params["date"]
      render json: {"data": {"attributes": {"revenue": merchant.total_revenue_by_date(date)}}}
    else
      render json: {"data": {"attributes": {"revenue": merchant.total_revenue}}}
    end
  end

end
