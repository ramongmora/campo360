class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.float :surface
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
