class Crop < ApplicationRecord
  belongs_to :location
  has_many :schedules, as: :schedulable, dependent: :destroy
  has_many :transactions, as: :transactionable

  has_one :user, through: :location

  has_one_attached :photo

  validates :location, presence: true
  validates :sowing_date, :harvest_date, :surface, :kind, presence: true
  validates :surface, numericality: { greater_than: 0 }
  validates :follow, inclusion: { in: [true, false] }

  validate :sowing_date_before_harvest_date

  def display_name
    "Cosecha de #{kind} (#{sowing_date})"
  end

  private

  def sowing_date_before_harvest_date
    if sowing_date.present? && harvest_date.present? && sowing_date > harvest_date
      errors.add(:sowing_date, "must be before the harvest date")
    end
  end
end
