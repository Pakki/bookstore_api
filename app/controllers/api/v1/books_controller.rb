class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :admin?, only: %i[create update destroy]

  def index
    render json: BookSerializer.new(Book.all).serializable_hash.to_json
  end

  def show
    render json: BookSerializer.new(@book).serializable_hash.to_json
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: BookSerializer.new(book).serializable_hash.to_json, status: :created
    else
      render json: { errors: book.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: BookSerializer.new(@book).serializable_hash.to_json
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head 204
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :price)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def admin?
    head :forbidden unless current_user&.admin?
  end
end
