class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.top_by_revenue(limit = 3)
    select('items.*, sum(invoice_items.unit_price * quantity) as revenue')
    .joins(invoice_items: [invoice: :transactions])
    .merge(Transaction.unscoped.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order('revenue DESC')
    .limit(limit)
  end

  def self.top_by_number_sold(limit = 3)
    select('items.*, sum(quantity) as quantity')
    .joins(invoice_items: [invoice: :transactions])
    .merge(Transaction.unscoped.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order('quantity DESC')
    .limit(limit)
  end

  def self.best_day(id)
    select('CAST (invoices.created_at as DATE) as date, sum(quantity) as total')
    .joins(invoice_items: [invoice: :transactions])
    .where("items.id = #{id}")
    .merge(Transaction.unscoped.successful)
    .group("date")
    .order('total DESC, date DESC')
    .limit(1)[0]
    .date.to_s
  end

end
