class AgrobotMessage < ApplicationRecord
  belongs_to :location

  validates :role, inclusion: { in: %w[user assistant] }
  validates :content, presence: true
end
