class AddCategoryNameToBooks < ActiveRecord::Migration
  def change
    add_column :books, :category_name, :string
  end
end
