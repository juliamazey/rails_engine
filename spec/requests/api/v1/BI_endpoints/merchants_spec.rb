require 'rails_helper'

describe 'Merchants Business Intelligence API' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_3)
    @item_5 = create(:item, merchant: @merchant_4)

    @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, merchant_id: @merchant_1.id, created_at: "2019-03-10 07:13:13 UTC", customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_2.id)
    @invoice_4 = create(:invoice, merchant_id: @merchant_2.id, created_at: "2019-03-13 07:13:13 UTC")
    @invoice_5 = create(:invoice, merchant_id: @merchant_3.id, created_at: "2019-03-13 23:13:13 UTC")
    @invoice_6 = create(:invoice, merchant_id: @merchant_4.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 2)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 7, unit_price: 2)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 20, unit_price: 5)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 8)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 2)
    @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 2)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id)
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id)
    @transaction_5 = create(:transaction, invoice_id: @invoice_5.id)
    @transaction_6 = create(:transaction, invoice_id: @invoice_6.id)
  end
  it 'returns the top x merchants ranked by total revenue' do

    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)["data"]
    expect(top_merchants.count).to eq(3)

    top_merchants_ids = top_merchants.map {|merchant| merchant["id"].to_i}

    expect(top_merchants_ids).to eq([@merchant_2.id, @merchant_3.id, @merchant_1.id])
  end

  it 'returns the top x merchants ranked by total number of items sold' do

    get "/api/v1/merchants/most_items?quantity=3"

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)["data"]
    expect(top_merchants.count).to eq(3)

    top_merchants_ids = top_merchants.map {|merchant| merchant["id"].to_i}

    expect(top_merchants_ids).to eq([@merchant_2.id, @merchant_1.id, @merchant_3.id])

  end

  it 'returns the total revenue for a date x across all merchants' do

    date = "2019-03-13"


    get "/api/v1/merchants/revenue?date=#{date}"

    expect(response).to be_successful

    total = JSON.parse(response.body)["data"]["attributes"]["total_revenue"]

    expect(total).to eq("1.8")
  end


  it 'returns the total revenue for a single merchant' do

    get "/api/v1/merchants/#{@merchant_1.id}/revenue"


    expect(response).to be_successful

    revenue = JSON.parse(response.body)["data"]["attributes"]["revenue"]

    expect(revenue).to eq("0.28")
  end

  it 'returns the total revenue for a merchant for a specific date' do
    date = @invoice_2.created_at

    get "/api/v1/merchants/#{@merchant_1.id}/revenue?date=#{date}"

    expect(response).to be_successful

    revenue = JSON.parse(response.body)["data"]["attributes"]["revenue"]
    expect(revenue).to eq("0.14")
  end

  it 'returns the customer who has most total number of successful transactions' do

    get "/api/v1/merchants/#{@merchant_1.id}/favorite_customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]
    expect(customer["id"].to_i).to eq(@customer_2.id)
  end

end
