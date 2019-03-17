class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    id = params["invoice_id"].to_i
    transactions = Invoice.find(id).transactions
    render json: TransactionSerializer.new(transactions)
  end

end
