require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create(:merchant, id: 64, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    create(:merchant, id: 5, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:merchant, id: 75, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:06 UTC", updated_at: "2012-03-27 14:54:06 UTC")
    create(:merchant, id: 43, name: "Marks, Shanahan and Bauch", created_at: "2012-03-27 14:54:03 UTC", updated_at: "2012-03-27 14:54:03 UTC")

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(4)
  end

  it "can get one merchant by its id" do
    m = create(:merchant, id: 64, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    id = m.id

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can get one merchant using finders" do
    m = create(:merchant, id: 5, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    id = m.id
    name = m.name
    created_at = m.created_at
    updated_at = m.updated_at

    get "/api/v1/merchants/find?id=#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful
    expect(merchant["name"]).to eq(name)

    get "/api/v1/merchants/find?created_at=#{created_at}"

    expect(response).to be_successful
    expect(merchant["created_at"]).to eq("2012-03-27T14:53:59.000Z")

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    expect(merchant["updated_at"]).to eq("2012-03-27T14:53:59.000Z")
  end

  it "can get all merchants matches using finders" do
    merchant_1 = create(:merchant, id: 64, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    merchant_2 = create(:merchant, id: 5, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, id: 75, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:06 UTC")

    get "/api/v1/merchants/find_all?name=#{merchant_2.name}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchants.first["name"]).to eq(merchant_2.name)
    expect(merchants.count).to eq(1)

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful

    all_merchants = merchants.map {|merchant| merchant["created_at"]}

    expect(all_merchants).to eq(["2012-03-27T14:54:05.000Z", "2012-03-27T14:54:05.000Z"])
    expect(merchants.count).to eq(2)
  end

  it "can return a random resource" do
    merchant_1 = create(:merchant, id: 64, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    merchant_2 = create(:merchant, id: 5, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, id: 75, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:06 UTC")

    merchants_names = [merchant_1.name, merchant_2.name, merchant_3.name]

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants_names).to include(merchant["name"])
  end

end
