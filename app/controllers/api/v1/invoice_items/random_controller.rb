class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.take)
  end

end
