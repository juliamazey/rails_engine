class Api::V1::Merchants::RevenueDateController < ApplicationController

  def show
    date = params["date"]
    render json: {"data": {"attributes": {"total_revenue": Merchant.total_revenue_by_date(date)}}}
  end

end
