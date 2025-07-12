class User < ApplicationRecord
  has_many :locations
  has_many :employees, through: :locations
  has_many :crops, through: :locations
  has_many :animals, through: :locations
  has_many :schedules, through: :locations

  belongs_to :main_location, class_name: "Location", optional: true

  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
