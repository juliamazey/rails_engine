class Api::V1::Items::BestDayController < ApplicationController

  def show
    id = params["id"].to_i
    render json: {"data": {"attributes": {"best_day": Item.best_day(id)}}}
  end
end
