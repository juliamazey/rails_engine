class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    id = params["id"].to_i
    invoice = Transaction.find(id).invoice
    render json: InvoiceSerializer.new(invoice)
  end

end
