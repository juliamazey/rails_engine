class Api::V1::Items::MostRevenuesController < ApplicationController

  def index
    limit = params["quantity"].to_i
    render json: ItemSerializer.new(Item.top_by_revenue(limit))
  end

end
