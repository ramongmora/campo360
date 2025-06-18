class CreateCrops < ActiveRecord::Migration[7.1]
  def change
    create_table :crops do |t|
      t.references :location, null: false, foreign_key: true
      t.date :sowing_date
      t.date :harvest_date
      t.float :surface
      t.string :kind
      t.boolean :follow

      t.timestamps
    end
  end
end
