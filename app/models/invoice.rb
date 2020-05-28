class Invoice < ApplicationRecord
  belongs_to :client

  validates :end_date, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0} 
  validates :description, presence: true, length: { minimum: 50 },
    unless: Proc.new { |a| a.description.blank? }
end
