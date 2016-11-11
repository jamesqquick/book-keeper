class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:feed, :friends]

  
  def index
    unless params[:q].nil?
      @users = User.where("username like ?", "%#{params[:q]}%")
    end
  end
  
  def show
    @user = User.find(params[:id])
    @usersbooks = @user.books.where(list_type: "read")
    @readUserBooks = UserBook.where(user_id: @user.id, list_type: "read")
    @readBooks = []
    @readUserBooks.each do |userReadBook|
      @readBooks.push(Book.find(userReadBook.book_id)) 
    end
    
    @queuedBooks = []
    @queuedUserBooks = UserBook.where(user_id: @user.id, list_type: "queue")
    @queuedUserBooks.each do |userQueuedBook|
      @queuedBooks.push(Book.find(userQueuedBook.book_id)) 
    end
  end
  
  def feed
      @friends =  current_user.all_following;
      @friendActivities = Array.new
      @friends.each do |friend|
          @friendActivities += UserBook.where("user_id": friend.id)
      end
      @friendActivities = @friendActivities.sort_by &:created_at
      @friendActivities = @friendActivities.reverse
  end
  
  def friends
      @follow = Follow.new
      @followings = current_user.all_following
      unless params[:q].nil?
        @users = User.where("username":params[:q])
      end
  end
end
