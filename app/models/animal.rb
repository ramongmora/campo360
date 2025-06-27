class Animal < ApplicationRecord
  belongs_to :location
  belongs_to :animal_group
  has_many :schedules, as: :schedulable

  has_one :user, through: :location

  validates :location, :animal_group, presence: true
  validates :alias, presence: true
  validates :breed, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :follow, inclusion: { in: [true, false] }
end
