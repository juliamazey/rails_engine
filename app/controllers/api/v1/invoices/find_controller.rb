class Api::V1::Invoices::FindController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(invoices_params))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(invoices_params))
  end

  private
  def invoices_params
    params.permit(:id, :customer_id, :merchant_id, :status_price, :created_at, :updated_at)
  end

end
