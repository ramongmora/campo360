class Schedule < ApplicationRecord
  belongs_to :schedulable, polymorphic: true
  belongs_to :location
  belongs_to :activity
  has_one :user, through: :location

  validates :start_date, :schedulable, :end_date, :activity, presence: true
  validate :start_date_before_end_date

  private
  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:start_date, "must be before end date")
    end
  end
end
