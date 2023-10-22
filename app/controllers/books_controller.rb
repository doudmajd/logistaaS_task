class BooksController < ApplicationController
  before_action :set_book, only: [ :edit, :update]

  def index
    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      select_options: {
      }
    ) or return

    @books = @filterrific.find.includes(:author)

    respond_to do |format|
      format.html
      format.js
    end
  end



  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path(@author)
        else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path(), notice: "Book was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  def download_csv
    @books = Book.all

    respond_to do |format|
      format.csv do
        send_data generate_csv(@books), filename: 'books.csv'
      end
    end
  end
  private

  def books_by_author
    @author = Author.find(params[:author_id])
    @books = @author.books
  end
  def generate_csv(books)
    csv_data = "Book Name,Release Date,Author Name\n"

    books.each do |book|
      csv_data << "#{book.name},#{book.release_date},#{book.author.name}\n"
    end

    csv_data
  end




  def set_book
    @book = Book.find(params[:id])
  end
  def set_author
    @author = Author.find(params[:author_id])
  end
  def book_params
    params.require(:book).permit(:name, :release_date, :author_id)
  end
end
