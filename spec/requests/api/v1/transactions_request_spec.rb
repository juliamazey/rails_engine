require 'rails_helper'

describe "Transactions API" do

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

    @transaction_1 = create(:transaction, id: 1, invoice_id: 1, credit_card_number: 4654405418249632, result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @transaction_2 = create(:transaction, id: 2, invoice_id: 2,  credit_card_number: 4580251236515201, result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @transaction_3 = create(:transaction, id: 3, invoice_id: 3,  credit_card_number: 4354495077693036, result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @transaction_4 = create(:transaction, id: 4, invoice_id: 4,  credit_card_number: 4515551623735607, result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

  end

  it "sends a list of transactions" do

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(4)
  end

  it "can get one transaction by its id" do

    get "/api/v1/transactions/#{@transaction_1.id}"
    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["id"].to_i).to eq(@transaction_1.id)
  end

  it "can get one transaction using finders" do
    id = @transaction_1.id
    invoice_id = @transaction_1.invoice_id
    credit_card_number = @transaction_1.credit_card_number
    result = @transaction_1.result
    created_at = @transaction_1.created_at
    updated_at = @transaction_1.updated_at

    get "/api/v1/transactions/find?id=#{id}"
    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["id"].to_i).to eq(id)

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"
    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["attributes"]["invoice_id"].to_i).to eq(invoice_id)

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    expect(response).to be_successful
    expect(transaction["attributes"]["credit_card_number"]).to eq(credit_card_number)

    get "/api/v1/transactions/find?result=#{result}"

    expect(response).to be_successful
    expect(transaction["attributes"]["result"]).to eq(result)

    get "/api/v1/transactions/find?created_at=#{created_at}"

    expect(response).to be_successful
    expect(transaction["attributes"]["created_at"]).to eq("2012-03-27T14:54:09.000Z")

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    expect(transaction["attributes"]["updated_at"]).to eq("2012-03-27T14:54:09.000Z")

  end

  it "can get all transactions matches using finders" do

    get "/api/v1/transactions/find_all?result=#{@transaction_2.result}"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(transactions.first["attributes"]["result"]).to eq(@transaction_2.result)
    expect(transactions.count).to eq(4)

    get "/api/v1/transactions/find_all?created_at=#{@transaction_1.created_at}"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    all_transactions = transactions.map {|transaction| transaction["attributes"]["created_at"]}

    expect(all_transactions).to eq(["2012-03-27T14:54:09.000Z", "2012-03-27T14:54:09.000Z"])
    expect(transactions.count).to eq(2)
  end

  it "can return a random resource" do

    transactions_ids = [@transaction_1.id, @transaction_2.id, @transaction_3.id]

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions_ids).to include(transaction["attributes"]["id"])
  end

  it "can return the associated invoice for a transaction" do

    get "/api/v1/transactions/#{@transaction_1.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(@transaction_1.invoice_id)
  end

end
