class Activity < ApplicationRecord
  has_many :schedules

  validates :name, presence: true, uniqueness: true
end
