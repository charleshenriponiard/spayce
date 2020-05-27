class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :companies

  validates :email, presence: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, format: { with: /0[1-9]\s(?:[0-9]{2}\s){3}[0-9]{2}/, message: "invalide, style valide => '0X XX XX XX XX'" }
end
