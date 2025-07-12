class AddMainLocationIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :main_location_id, :integer
  end
end
