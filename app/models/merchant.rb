class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices

  validates_presence_of :name

  def self.top_by_revenue(limit = 3)
    select('merchants.*, sum(unit_price*quantity) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order('revenue DESC')
    .limit(limit)
  end


  def self.top_by_items_sold(limit = 3)
    select('merchants.*, sum(invoice_items.quantity) AS total')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('total DESC')
    .limit(limit)
  end

  def self.total_revenue_by_date(date = Date.today)
    select('sum(unit_price*quantity / 100.0) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .where(invoices: {created_at: Time.parse(date).utc.all_day})[0]
    .revenue
  end

  def total_revenue
    invoices.select('sum(invoice_items.unit_price*quantity / 100.0) AS revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.unscoped.successful)
    .group(:merchant_id)[0]
    .revenue
  end

  def total_revenue_by_date(date = Date.today)
    invoices.select('sum(invoice_items.unit_price*quantity / 100.0) AS revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.unscoped.successful)
    .where(created_at: Time.parse(date).utc.all_day)
    .group(:merchant_id)[0]
    .revenue
  end

  def favorite_customer
    invoice_customer = invoices.select('customers.*, count(invoices.id) as total_count')
    .joins(:customer, :transactions)
    .merge(Transaction.unscoped.successful)
    .merge(Invoice.shipped)
    .group("customers.id")
    .order('total_count DESC').first
    Customer.find(invoice_customer.id)
  end

  def self.favorite_merchant(id)
    select('merchants.*, count(invoices.merchant_id) as merchant_count')
    .joins(invoices: [:transactions, :customer])
    .where("customers.id = #{id}")
    .merge(Transaction.unscoped.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order("merchant_count DESC")
    .limit(1)[0]
  end


end
