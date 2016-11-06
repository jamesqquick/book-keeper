class Book < ActiveRecord::Base
    belongs_to :user
    has_many :reviews
    has_many :user_books, dependent: :destroy
    has_many :users, through: :user_books
end
