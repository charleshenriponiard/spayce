class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :companies

  validates :email, presence: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, presence: true
  validates :status, presence: true, numericality: {only_integer: true}
  validates :status, inclusion: { in: [0, 1], message: "status doit égale à 0 ou 1" }
  validates :phone_number, format: { with: /0[1-9]\s(?:[0-9]{2}\s){3}[0-9]{2}/, message: "invalide, style valide => '0X XX XX XX XX'" }
  validates :phone_number, length: { is: 14, message: "nombre de chiffre invalide" }
end
