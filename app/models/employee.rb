class Employee < ApplicationRecord
  belongs_to :location

  has_one :user, through: :location
  has_many :transactions, as: :transactionable

  validates :first_name, :last_name, presence: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :citizen_register, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def display_name
    "#{first_name} #{last_name}"
  end
end
