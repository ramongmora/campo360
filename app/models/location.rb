class Location < ApplicationRecord
  belongs_to :user
  has_many :employees
  has_many :crops
  has_many :animals
  has_many :schedules

  validates :name, :surface, :address, :latitude, :longitude, presence: true
  validates :name, uniqueness: true
  validates :surface, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

end
