class Animal < ApplicationRecord
  belongs_to :location
  belongs_to :animal_group
  has_many :schedules, as: :schedulable

  validates :location, :animal_group, :alias, :breed, :birth_date, presence: true
  validates :gender, inclusion: { in: %w[male female] }
  validates :follow, inclusion: { in: [true, false] }
end
