class AddListTypeToUserBook < ActiveRecord::Migration
  def change
    add_column :user_books, :list_type, :string
  end
end
