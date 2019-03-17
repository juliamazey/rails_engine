class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    id = params["customer_id"].to_i
    transactions = Customer.find(id).transactions
    render json: TransactionSerializer.new(transactions)
  end

end
