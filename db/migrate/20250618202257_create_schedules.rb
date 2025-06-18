class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :schedulable, polymorphic: true, null: false
      t.references :location, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
