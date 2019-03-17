class Api::V1::Invoices::MerchantsController < ApplicationController

  def show
    id = params["invoice_id"].to_i
    merchant = Invoice.find(id).merchant
    render json: MerchantSerializer.new(merchant)
  end

end
