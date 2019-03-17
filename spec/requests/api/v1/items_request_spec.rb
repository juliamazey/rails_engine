require 'rails_helper'

describe "Items API" do

  before :each do
    @merchant = create(:merchant, id: 1, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")

    @item_1 = create(:item, id: 1, name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: 75107, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_2 = create(:item, id: 2, name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.", unit_price: 67076, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_3 = create(:item, id: 3, name: "Item Ea Voluptatum,", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.", unit_price: 32301, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_4 = create(:item, id: 4, name: "Item Nemo Facere", description: "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.", unit_price: 4291, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it "sends a list of items" do
    # create(:merchant, id: 64, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    # create(:merchant, id: 5, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    # create(:merchant, id: 75, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:06 UTC", updated_at: "2012-03-27 14:54:06 UTC")
    # create(:merchant, id: 43, name: "Marks, Shanahan and Bauch", created_at: "2012-03-27 14:54:03 UTC", updated_at: "2012-03-27 14:54:03 UTC")

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(4)
  end

  it "can get one item by its id" do

    get "/api/v1/items/#{@item_1.id}"
    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["id"].to_i).to eq(@item_1.id)
  end

  it "can get one item using finders" do
    id = @item_1.id
    name = @item_1.name
    description = @item_1.description
    unit_price = @item_1.unit_price
    merchant_id = @item_1.merchant_id
    created_at = @item_1.created_at
    updated_at = @item_1.updated_at

    get "/api/v1/items/find?id=#{id}"
    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful
    expect(item["attributes"]["name"]).to eq(name)

    get "/api/v1/items/find?name=#{description}"

    expect(response).to be_successful
    expect(item["attributes"]["description"]).to eq(description)

    get "/api/v1/items/find?name=#{unit_price}"

    expect(response).to be_successful
    expect(item["attributes"]["unit_price"]).to eq(unit_price)

    get "/api/v1/items/find?name=#{merchant_id}"

    expect(response).to be_successful
    expect(item["attributes"]["merchant_id"]).to eq(merchant_id)

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful
    expect(item["attributes"]["created_at"]).to eq("2012-03-27T14:53:59.000Z")

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    expect(item["attributes"]["updated_at"]).to eq("2012-03-27T14:53:59.000Z")
  end

  it "can get all items matches using finders" do

    get "/api/v1/items/find_all?name=#{@item_2.name}"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(items.first["attributes"]["name"]).to eq(@item_2.name)
    expect(items.count).to eq(1)

    get "/api/v1/items/find_all?created_at=#{@item_1.created_at}"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    all_items = items.map {|item| item["attributes"]["created_at"]}

    expect(all_items).to eq(["2012-03-27T14:53:59.000Z", "2012-03-27T14:53:59.000Z", "2012-03-27T14:53:59.000Z", "2012-03-27T14:53:59.000Z"])
    expect(items.count).to eq(4)
  end

  it "can return a random resource" do

    items_names = [@item_1.name, @item_2.name, @item_3.name]

    get "/api/v1/items/random"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items_names).to include(item["attributes"]["name"])
  end

end
