require 'rails_helper'

describe "Customers API" do

  before :each do

    @customer_1 = create(:customer, id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @customer_2 = create(:customer, id: 2, first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_3 = create(:customer, id: 3, first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_4 = create(:customer, id: 4, first_name: "Leanne", last_name: "Braun", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

  end

  it "sends a list of customers" do

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(4)
  end

  it "can get one customer by its id" do

    get "/api/v1/customers/#{@customer_1.id}"
    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["id"].to_i).to eq(@customer_1.id)
  end

  it "can get one customer using finders" do
    id = @customer_1.id
    first_name = @customer_1.first_name
    last_name = @customer_1.last_name
    created_at = @customer_1.created_at
    updated_at = @customer_1.updated_at

    get "/api/v1/customers/find?id=#{id}"
    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["id"].to_i).to eq(id)

    get "/api/v1/customers/find?name=#{first_name}"

    expect(response).to be_successful
    expect(customer["attributes"]["first_name"]).to eq(first_name)

    get "/api/v1/customers/find?name=#{last_name}"

    expect(response).to be_successful
    expect(customer["attributes"]["last_name"]).to eq(last_name)

    get "/api/v1/customers/find?name=#{created_at}"

    expect(response).to be_successful
    expect(customer["attributes"]["created_at"]).to eq("2012-03-27T14:54:09.000Z")

    get "/api/v1/customers/find?created_at=#{updated_at}"

    expect(response).to be_successful
    expect(customer["attributes"]["updated_at"]).to eq("2012-03-27T14:54:09.000Z")

  end

  it "can get all customers matches using finders" do

    get "/api/v1/customers/find_all?first_name=#{@customer_2.first_name}"

    customers = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(customers.first["attributes"]["first_name"]).to eq(@customer_2.first_name)
    expect(customers.count).to eq(1)

    get "/api/v1/customers/find_all?created_at=#{@customer_1.created_at}"

    customers = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    all_customers = customers.map {|customer| customer["attributes"]["created_at"]}

    expect(all_customers).to eq(["2012-03-27T14:54:09.000Z"])
    expect(customers.count).to eq(1)
  end

  it "can return a random resource" do

    customers_ids = [@customer_1.id, @customer_2.id, @customer_3.id]

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customers_ids).to include(customer["attributes"]["id"])
  end

  it "can return invoices associated with a customer" do
    invoices = create_list(:invoice, 4, customer: @customer_1)
    invoices_ids = invoices.map { |invoice| invoice.id}

    get "/api/v1/customers/#{@customer_1.id}/invoices"
    customer_invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_invoices.count).to eq(4)

    c_i_ids = customer_invoices.map { |invoice| invoice["attributes"]["id"] }

    expect(invoices_ids).to eq(c_i_ids)
  end

  it "can return transactions associated with a customer" do
    invoice_1 = create(:invoice, customer_id: @customer_1.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, invoice_id: invoice_1.id)

    transactions = [transaction_1, transaction_2, transaction_3]

    transactions_ids = transactions.map { |transaction| transaction.id}

    get "/api/v1/customers/#{@customer_1.id}/transactions"
    customer_transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_transactions.count).to eq(3)

    i_t_ids = customer_transactions.map { |transaction| transaction["attributes"]["id"] }

    expect(transactions_ids).to eq(i_t_ids)
  end

end
