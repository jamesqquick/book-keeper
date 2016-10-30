class BooksController < ApplicationController
    
    before_action :find_book , only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except:[:index, :show]
    
    def index
        @books = Book.all.order("updated_at DESC").take(4)
    end
    
    def new
        @book = current_user.books.build

        if params[:q].nil?
        else
            @searchBooks = GoogleBooks.search(params[:q], {:count => 10})
        end
        #Get list of categories to be shown in the new page
        #Options needs to be in form of an array - mapping the id to the name of the category
        @categories = Category.all.map{ |c| [c.name, c.id] }
        
    end
    
    def create
        @book = current_user.books.build(book_params)
        if @book.save
            redirect_to root_path
        else
            redirect_to root_path
        end
    end
    
    def show
        @reviews = @book.reviews.order("updated_at DESC")
        #Check to see if the user has already reviewed this book
        @review = @book.reviews.where(user_id: current_user.id).first_or_initialize
    end
    
    
    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    
    def update
        @book.category_id = params[:category_id]
        if @book.update(book_params)
            redirect_to book_path(@book)
        else
            redirect_to 'edit'
        end
    end
    
    def destroy
        if @book.destroy
            redirect_to root_path
        else
            render 'show'
        end
    end
    
    private
        def book_params
            params.require(:book).permit(:title, :author, :description, :category_name, :image_url, :id)
        end
        
        def find_book
            @book = Book.find(params[:id])
        end
end
