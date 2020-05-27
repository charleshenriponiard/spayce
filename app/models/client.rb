class Client < ApplicationRecord
  belongs_to :company

  validates_with EmailValidator
  validates :name, presence: true
  validates :email, presence: true
  
end
