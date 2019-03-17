class Api::V1::Items::MostItemsController < ApplicationController

  def index
    limit = params["quantity"].to_i
    render json: ItemSerializer.new(Item.top_by_number_sold(limit))
  end


end
