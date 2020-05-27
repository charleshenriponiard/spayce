class Client < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :email, presence: true, email: true
end
