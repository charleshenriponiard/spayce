class Company < ApplicationRecord
  belongs_to :user

  validates :siret, numericality: true
  validates :siret, numericality: { only_integer: true }
  validates :siret, length: { is: 14 }
end
