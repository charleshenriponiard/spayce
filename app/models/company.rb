class Company < ApplicationRecord
  belongs_to :user

  has_many :clients, dependent: :destroy
  has_many :invoices, through: :clients

  validates_associated :user
  validates_associated :clients 
  validates :siret, numericality: true
  validates :siret, numericality: { only_integer: true }
  validates :siret, length: { is: 14 }
  validates :name, presence: true
  validates :vat, presence: true 
  validates :vat, inclusion: { in: [0, 2.1, 5.5, 10, 20],
    message: "%{value} n'est pas une TVA valide" }
  validates :legal_structure, presence: true
  validates :start_activity, presence: true
  validate :start_activity_cant_be_in_the_future
  validates :code_ape, format: {with: /(?:[0-9]{4})[a-zA-Z]/, message: "format invalide ex: '0114Z'"}
  validates :zip_code, format: {with: /(?:[0-9]{5})/,  message: "format invalide ex: '33000'"}
  validates :zip_code, numericality: {greater_than: 1001, less_than: 99138 }
  validates :city, presence: true 
  validates :country, presence: true
  validates :street_number, presence: true
  validates :street, presence: true

  private

  def start_activity_cant_be_in_the_future
    if start_activity.present? && start_activity > Date.today
      errors.add(:start_activity, "ne peut pas être dans le future")
    end
  end
end
