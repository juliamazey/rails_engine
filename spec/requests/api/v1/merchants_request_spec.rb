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
end
