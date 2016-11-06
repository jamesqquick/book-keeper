class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_book
  before_action :authenticate_user!


  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.book_id = @book.id
    
    if @review.save
      flash[:success] = "Review successfully created"
      redirect_to @book
    else
      flash[:danger] = "Review not created"
      redirect_to @book
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update(review_params)
        flash[:success] = "Review successfully updated"
        redirect_to @book
      else
        flash[:danger] = "Review not updated"
        redirect_to @book 
      end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    flash[:success] = "Review successfully deleted"
    redirect_to @book

  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment, :rating)
    end
end
