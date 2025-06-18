class CreateAnimals < ActiveRecord::Migration[7.1]
  def change
    create_table :animals do |t|
      t.references :location, null: false, foreign_key: true
      t.string :breed
      t.string :alias
      t.date :birth_date
      t.string :gender
      t.boolean :follow
      t.references :animal_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
