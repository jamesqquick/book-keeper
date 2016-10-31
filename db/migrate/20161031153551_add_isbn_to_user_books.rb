class AddIsbnToUserBooks < ActiveRecord::Migration
  def change
    add_column :user_books, :isbn, :string
  end
end
