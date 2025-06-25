class RemoveBreedFromAnimals < ActiveRecord::Migration[7.1]
  def change
    remove_column :animals, :breed, :string
  end
end
