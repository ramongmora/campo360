class CreateBreeds < ActiveRecord::Migration[7.1]
  def change
    create_table :breeds do |t|
      t.string :breed_type
      t.references :animal_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
