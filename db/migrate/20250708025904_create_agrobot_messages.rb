class CreateAgrobotMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :agrobot_messages do |t|
      t.references :location, null: false, foreign_key: true
      t.string :role
      t.text :content

      t.timestamps
    end
  end
end
