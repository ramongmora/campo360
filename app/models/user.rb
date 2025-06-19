class User < ApplicationRecord
  has_many :locations
  has_many :employees, through: :locations
  has_many :crops, through: :locations
  has_many :animals, through: :locations
  has_many :schedules, through: :locations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
