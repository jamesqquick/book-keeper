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
      redirect_to @book, notice: 'Review was successfully created.' 
    else
      redirect_to @book, notice: 'Review not created' 
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update(review_params)
        redirect_to @book, notice: 'Review was successfully updated.' 
      else
        redirect_to @book, notice: 'Review not updated' 
      end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    redirect_to @book, notice: 'Review was successfully destroyed.'

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
