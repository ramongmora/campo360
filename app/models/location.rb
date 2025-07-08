class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user

  has_many :employees, dependent: :destroy
  has_many :crops, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :agrobot_messages, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :surface, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :address, presence: true
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true

  def last_schedules
    schedules.last(5)
  end

  def upcoming_schedules
    schedules.where('end_date > ?', Date.today).order(end_date: :desc).limit(5)
  end

  def recent_schedules
    schedules.where('end_date < ?', Date.today).order(end_date: :asc).limit(5)
  end
end
