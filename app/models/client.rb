class Client < ApplicationRecord
  belongs_to :company
  has_many :invoices

  validates :name, presence: true
  validates :email, presence: true, email: true
end
