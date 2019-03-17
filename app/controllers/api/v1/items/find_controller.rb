class Api::V1::Items::FindController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.where(item_params).first)
  end

  def index
    render json: ItemSerializer.new(Item.where(item_params))
  end

  private
  def item_params
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).round
    end
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end
