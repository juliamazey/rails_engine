class Api::V1::Merchants::CustomersController < ApplicationController

  def show
    merchant = Merchant.find(params["merchant_id"])
    render json: CustomerSerializer.new(merchant.favorite_customer)
  end

  # def index
  #   id = params["merchant_id"].to_i
  #   render json: CustomerSerializer.new(Customer.pending_invoices(id))
  # end

end
