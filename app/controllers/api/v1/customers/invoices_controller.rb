class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    id = params["customer_id"].to_i
    invoices = Customer.find(id).invoices
    render json: InvoiceSerializer.new(invoices)
  end

end
