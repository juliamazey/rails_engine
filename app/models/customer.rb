class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  # def self.pending_invoices(id)
  #   self.joins(invoices: [:transactions])
  #   .where("merchants.id = #{id}")
  #   .where("transactions.result = 1")
  # end


end
