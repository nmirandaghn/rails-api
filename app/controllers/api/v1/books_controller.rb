class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    @books = Book.all
    json_response "Index books successfully", true, {books: @books}, :ok
  end
  
  def create
    book = Book.new(book_params)

    if book.save
      json_response "Successfully created", true, {book: book}, :ok
    else
      json_response "Not created", false, {}, :unprocessable_entity
    end
  end

  def update
    if @book.save
      json_response "Successfully update", true, {book: @book}, :ok
    else
      json_response "Not created", false, {}, :unprocessable_entity
    end
  end

  def show
    json_response "Successfully show book", true, {book: @book}, :ok
  end

  def destroy
    if @book.delete
      json_response "Successfully deleted", true, {book: @book}, :ok
    else
      json_response "Not created", false, {}, :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end

  def load_book
    @book = Book.find_by(id: params[:id])

    return @book if @book
    json_response "Cannot get book", false, {}, :bad_request
  end
end