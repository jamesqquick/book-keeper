class UsersController < ApplicationController
  def index
    unless params[:q].nil?
      @users = User.where("username like ?", "%#{params[:q]}%")
    end
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books.take(3)
  end
end
