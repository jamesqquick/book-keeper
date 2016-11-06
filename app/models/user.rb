class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :books
  has_many :reviews, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  validates :password, :presence => true, length: {in: 6..20}
  validates :email, :presence => true, :uniqueness => true
  validates :username, :presence => true, :uniqueness => true, length: { in: 6..20 }
end
