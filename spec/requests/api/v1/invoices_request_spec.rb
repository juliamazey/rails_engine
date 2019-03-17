require 'rails_helper'

describe "Invoices API" do

  before :each do
    @merchant_1 = create(:merchant, id: 1, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    @merchant_2 = create(:merchant, id: 2, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_3 = create(:merchant, id: 3, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:06 UTC", updated_at: "2012-03-27 14:54:06 UTC")
    @merchant_4 = create(:merchant, id: 4, name: "Marks, Shanahan and Bauch", created_at: "2012-03-27 14:54:03 UTC", updated_at: "2012-03-27 14:54:03 UTC")

    @customer_1 = create(:customer, id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @customer_2 = create(:customer, id: 2, first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_3 = create(:customer, id: 3, first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_4 = create(:customer, id: 4, first_name: "Leanne", last_name: "Braun", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = create(:invoice, id: 1, customer_id: 1, merchant_id: 1, status: "shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = create(:invoice, id: 2, customer_id: 2, merchant_id: 2, status: "shipped", created_at: "2012-03-12 05:54:09 UTC", updated_at: "2012-03-12 05:54:09 UTC")
    @invoice_3 = create(:invoice, id: 3, customer_id: 3, merchant_id: 3, status: "shipped", created_at: "2012-03-10 00:54:09 UTC", updated_at: "2012-03-10 00:54:09 UTC")
    @invoice_4 = create(:invoice, id: 4, customer_id: 4, merchant_id: 4, status: "shipped", created_at: "2012-03-24 15:54:10 UTC", updated_at: "2012-03-24 15:54:10 UTC")

  end

  it "sends a list of invoices" do

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(4)
  end

  it "can get one invoice by its id" do

    get "/api/v1/invoices/#{@invoice_1.id}"
    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(@invoice_1.id)
  end

  it "can get one invoice using finders" do
    id = @invoice_1.id
    customer_id = @invoice_1.customer_id
    merchant_id = @invoice_1.merchant_id
    status = @invoice_1.status
    created_at = @invoice_1.created_at
    updated_at = @invoice_1.updated_at

    get "/api/v1/invoices/find?id=#{id}"
    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)

    get "/api/v1/invoices/find?name=#{merchant_id}"

    expect(response).to be_successful
    expect(invoice["attributes"]["merchant_id"]).to eq(merchant_id)

    get "/api/v1/invoices/find?name=#{customer_id}"

    expect(response).to be_successful
    expect(invoice["attributes"]["customer_id"]).to eq(customer_id)

    get "/api/v1/invoices/find?name=#{status}"

    expect(response).to be_successful
    expect(invoice["attributes"]["status"]).to eq(status)

    get "/api/v1/invoices/find?name=#{created_at}"

    expect(response).to be_successful
    expect(invoice["attributes"]["created_at"]).to eq("2012-03-25T09:54:09.000Z")

    get "/api/v1/invoices/find?created_at=#{updated_at}"

    expect(response).to be_successful
    expect(invoice["attributes"]["updated_at"]).to eq("2012-03-25T09:54:09.000Z")

  end

  it "can get all invoices matches using finders" do

    get "/api/v1/invoices/find_all?status=#{@invoice_2.status}"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(invoices.first["attributes"]["status"]).to eq(@invoice_2.status)
    expect(invoices.count).to eq(4)

    get "/api/v1/invoices/find_all?created_at=#{@invoice_1.created_at}"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    all_invoices = invoices.map {|io| io["attributes"]["created_at"]}

    expect(all_invoices).to eq(["2012-03-25T09:54:09.000Z"])
    expect(invoices.count).to eq(1)
  end

  it "can return a random resource" do

    invoices_ids = [@invoice_1.id, @invoice_2.id, @invoice_3.id]

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices_ids).to include(invoice["attributes"]["id"])
  end

end
