require 'csv'

namespace :import do
  desc "Import merchants from CSV file"

  task merchants: :environment do
    CSV.foreach("./lib/merchants.csv", headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end
end
