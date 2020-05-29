class Client < ApplicationRecord
  belongs_to :company
  has_many :invoices

  validates_associated :company
  validates_associated :invoices
  validates :name, presence: true
  validates :email, presence: true, email: true
end
