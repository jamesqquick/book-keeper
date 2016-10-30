class AddBookRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :book, index: true, foreign_key: true
  end
end
