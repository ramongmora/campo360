class AddCategoryToActivity < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :category, :string
  end
end
