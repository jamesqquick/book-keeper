class RemoveBookIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :book_id, :integer
  end
end
