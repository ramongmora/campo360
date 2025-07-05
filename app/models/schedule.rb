class Schedule < ApplicationRecord
  belongs_to :location
  belongs_to :activity
  belongs_to :schedulable, polymorphic: true # Animal o Crop

  has_one :user, through: :location

  validates :schedulable, presence: true
  validates :location, presence: true
  validates :activity, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_date_before_end_date

  private

  def start_date_before_end_date
    return unless start_date.present? && end_date.present? && start_date > end_date

    errors.add(:start_date, 'must be before end date')
  end
end
