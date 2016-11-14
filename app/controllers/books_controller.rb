class BooksController < ApplicationController
    
    before_action :find_book , only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except:[:index, :show]
    
    def index
        redirect_to feed_path if current_user
        #Get all the most recently read books regardless of who read them
        @books = UserBook.all.order("created_at DESC").take(4)
    end
    
    def new
        @book = Book.new

        if params[:q].nil?
        else
            #Search Google Books
            @unfilteredSearchBooks = GoogleBooks.search(params[:q], {:count => 10})
            #Filter by books that have an ISBN Number
            @searchBooks = @unfilteredSearchBooks.select  {|book| book.isbn.present?}
        end
    end
    
    def create
        # If the book has not been created, then create it
        # Either retrieve the book or create it, then add an association between user and book in UserBook table
        @book = Book.where(isbn: params[:book][:isbn]).first
        if @book
            @userBook = UserBook.create(user_id: current_user.id, book_id: @book.id, isbn: @book.isbn, list_type: params[:type])
            if @userBook.save
                redirect_to new_book_path
            else
                redirect_to new_book_path
            end
        #Else create the book and then the association
        else
            @book = Book.new(book_params)
            if @book.save
                #how to add the type parameter?
                @userBook = UserBook.create(user_id: current_user.id, book_id: @book.id, isbn: @book.isbn, list_type: params[:type])
                @userBook.save
                redirect_to new_book_path
            else
                redirect_to new_book_path
            end          
        end

    end
    
    def show
            @reviews = @book.reviews.order("updated_at DESC")
        if current_user
            #Check to see if the user has already reviewed this book
            @review = @book.reviews.where(user_id: current_user.id).first_or_initialize
        end
    end
    
    
    def edit
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
            params.require(:book).permit(:title, :author, :description, :category_name, :image_url, :isbn, :list_type)
        end
        
        def find_book
            @book = Book.find(params[:id])
        end
end
