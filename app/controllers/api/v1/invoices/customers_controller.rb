class Api::V1::Invoices::CustomersController < ApplicationController

  def show
    id = params["invoice_id"].to_i
    invoice = Invoice.find(id)
    render json: CustomerSerializer.new(invoice.customer)
  end

end
