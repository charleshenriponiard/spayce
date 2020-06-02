class Invoice < ApplicationRecord
  belongs_to :client

  
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :file, presence: true
  validates :ref_number, presence: true
  validates :description, presence: true, length: { minimum: 50 },
    unless: Proc.new { |a| a.description.blank? }
  validates :end_date, presence: true
  validate :end_date_cant_be_in_the_past
  validates :status, presence: true, numericality: {only_integer: true}
  validates :status, inclusion: { in: [0, 1, 2, 3, 4], message: "status doit être entre 0 et 4" }

  private

  def end_date_cant_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "ne peut pas être dans le passé")
    end
  end
end
