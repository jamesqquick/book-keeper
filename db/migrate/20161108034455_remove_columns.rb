class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :user_books, :type
  end
end
