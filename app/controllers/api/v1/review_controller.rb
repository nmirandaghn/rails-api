class ReviewsController < ApplicationController
  before_action :load_book, only: [:index]
  before_action :load_review, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    @reviews = @book.reviews
    json_response "Index reviews succesfully", true, {reviews: @reviews}, :ok
  end
  
  def show
    json_response "Show review succesfully", true, {reviews: @reviews}, :ok
  end

  def create
    review = Review.new(review_params)
    review.book = params[:book_id]
    review.user = current_user

    if review.save
      json_response "Create review succesfully", true, {review: review}, :ok
    else
      json_response "Create review error", false, {}, :unprocessable_entity
    end
  end

  def update
    if correct_user(@review.user)
      if @review.update review_params
        json_response "Update review succesfully", true, {review: @review}, :ok
      else
        json_response "Update review error", false, {}, :unprocessable_entity
      end
    else
      json_response "Wrong user", false, {}, :unathorized
    end
  end

  def destroy
    if correct_user(@review.user)
      if @review.delete
        json_response "Delete review succesfully", true, {review: @review}, :ok
      else
        json_response "Delete review error", false, {}, :unprocessable_entity
      end
    else
      json_response "Wrong user", false, {}, :unathorized
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content_rating, :recommendation_rating)
  end

  def load_book
    @book = Book.find_by_id(id: params[:id])
    return @book if @book
    json_response "Cannot get book", false, {}, :bad_request
  end

  def load_review
    @review = Review.find_each(params[:id])
    return @review if @review
    json_response "Cannot get review", false, {}, :bad_request
  end
end