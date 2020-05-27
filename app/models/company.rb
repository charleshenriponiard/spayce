class Company < ApplicationRecord
  belongs_to :user
  has_many :clients, dependent: :destroy
  has_many :invoices, through: :clients

  validates :siret, numericality: true
  validates :siret, numericality: { only_integer: true }
  validates :siret, length: { is: 14 }
  validates :name, presence: true
  validates :legal_structure, presence: true
  validates :code_ape, format: {with: /(?:[0-9]{4})[a-zA-Z]/, message: "format invalide ex: '0114Z'"}
  validates :zip_code, format: {with: /(?:[0-9]{5})/,  message: "format invalide ex: '33000'"}
end
