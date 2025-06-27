class Breed < ApplicationRecord
  belongs_to :animal_group
  has_many :animals
end
