class Employee < ApplicationRecord
  belong_to :location

  validates :first_name, :last_name, :citizen_register, :salary, presence: true
  validates :citizen_register, uniqueness: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
