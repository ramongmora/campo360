class Animal < ApplicationRecord
  belongs_to :location
  has_many :schedules, as: :schedulable
  belongs_to :breed

  has_one :user, through: :location
  has_one_attached :photo

  validates :alias, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: %w[Macho Hembra] }, allow_nil: true
  validates :follow, inclusion: { in: [true, false] }
end
\
