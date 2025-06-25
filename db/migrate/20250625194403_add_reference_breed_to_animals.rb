class AddReferenceBreedToAnimals < ActiveRecord::Migration[7.1]
  def change
    add_reference :animals, :breed, null: false, foreign_key: true
  end
end
