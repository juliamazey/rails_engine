require 'rails_helper'

describe "Invoice Items API" do

  before :each do
    @merchant_1 = create(:merchant, id: 1, name: "Koepp, Waelchi and Donnelly", created_at: "2012-03-27 14:54:05 UTC", updated_at: "2012-03-27 14:54:05 UTC")
    @merchant_2 = create(:merchant, id: 2, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_3 = create(:merchant, id: 3, name: "Eichmann-Turcotte", created_at: "2012-03-27 14:54:06 UTC", updated_at: "2012-03-27 14:54:06 UTC")
    @merchant_4 = create(:merchant, id: 4, name: "Marks, Shanahan and Bauch", created_at: "2012-03-27 14:54:03 UTC", updated_at: "2012-03-27 14:54:03 UTC")

    @customer_1 = create(:customer, id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @customer_2 = create(:customer, id: 2, first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_3 = create(:customer, id: 3, first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @customer_4 = create(:customer, id: 4, first_name: "Leanne", last_name: "Braun", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @item_1 = create(:item, id: 1, name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: 75107, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_2 = create(:item, id: 2, name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.", unit_price: 67076, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_3 = create(:item, id: 3, name: "Item Ea Voluptatum,", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.", unit_price: 32301, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item_4 = create(:item, id: 4, name: "Item Nemo Facere", description: "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.", unit_price: 4291, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    @invoice_1 = create(:invoice, id: 1, customer_id: 1, merchant_id: 1, status: "shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_1 = create(:invoice, id: 2, customer_id: 2, merchant_id: 2, status: "shipped", created_at: "2012-03-12 05:54:09 UTC", updated_at: "2012-03-12 05:54:09 UTC")
    @invoice_1 = create(:invoice, id: 3, customer_id: 3, merchant_id: 3, status: "shipped", created_at: "2012-03-10 00:54:09 UTC", updated_at: "2012-03-10 00:54:09 UTC")
    @invoice_1 = create(:invoice, id: 4, customer_id: 4, merchant_id: 4, status: "shipped", created_at: "2012-03-24 15:54:10 UTC", updated_at: "2012-03-24 15:54:10 UTC")

    @invoice_item_1 = create(:invoice_item, id: 1, item_id: 1, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09 UTC")
    @invoice_item_2 = create(:invoice_item, id: 2, item_id: 2, invoice_id: 2, quantity: 9, unit_price: 23324, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @invoice_item_3 = create(:invoice_item, id: 3, item_id: 3, invoice_id: 3, quantity: 8, unit_price: 34873, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @invoice_item_4 = create(:invoice_item, id: 4, item_id: 4, invoice_id: 4, quantity: 3, unit_price: 2196, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")

  end

  it "sends a list of invoice items" do

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(4)
  end

  it "can get one item by its id" do

    get "/api/v1/items/#{@invoice_item_1.id}"
    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(@invoice_item_1.id)
  end

  it "can get one invoice_item using finders" do
    id = @invoice_item_1.id
    item_id = @invoice_item_1.item_id
    invoice_id = @invoice_item_1.invoice_id
    quantity = @invoice_item_1.quantity
    unit_price = @invoice_item_1.unit_price
    created_at = @invoice_item_1.created_at
    updated_at = @invoice_item_1.updated_at

    get "/api/v1/invoice_items/find?id=#{id}"
    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)

    get "/api/v1/invoice_items/find?name=#{item_id}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["item_id"]).to eq(item_id)

    get "/api/v1/invoice_items/find?name=#{invoice_id}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["invoice_id"]).to eq(invoice_id)

    get "/api/v1/invoice_items/find?name=#{quantity}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["quantity"]).to eq(quantity)

    get "/api/v1/invoice_items/find?name=#{unit_price}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["unit_price"]).to eq(unit_price)

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["created_at"]).to eq("2012-03-27T14:54:09.000Z")

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    expect(invoice_item["attributes"]["updated_at"]).to eq("2012-03-27T14:54:09.000Z")
  end

  it "can get all invoice items matches using finders" do

    get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_2.quantity}"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(invoice_items.first["attributes"]["quantity"]).to eq(@invoice_item_2.quantity)
    expect(invoice_items.count).to eq(1)

    get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item_1.created_at}"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    all_invoice_items = invoice_items.map {|ii| ii["attributes"]["created_at"]}

    expect(all_invoice_items).to eq(["2012-03-27T14:54:09.000Z", "2012-03-27T14:54:09.000Z", "2012-03-27T14:54:09.000Z", "2012-03-27T14:54:09.000Z"])
    expect(invoice_items.count).to eq(4)
  end

  it "can return a random resource" do

    items_names = [@item_1.name, @item_2.name, @item_3.name]

    get "/api/v1/items/random"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items_names).to include(item["attributes"]["name"])
  end

  it "can return the associated invoice for an invoice item" do

    get "/api/v1/invoice_items/#{@invoice_item_1.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(@invoice_item_1.invoice_id)
  end

  it "can return the associated item for an invoice item" do

    get "/api/v1/invoice_items/#{@invoice_item_1.id}/item"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["id"]).to eq(@invoice_item_1.item_id)

  end

end
