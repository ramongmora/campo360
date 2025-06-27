class RemoveAnimalGroupFromAnimals < ActiveRecord::Migration[7.1]
  def change
    remove_reference :animals, :animal_group, index: true, foreign_key: true
  end
end
