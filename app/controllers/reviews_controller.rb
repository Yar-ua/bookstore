class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to book_path(id: @book.id)
      flash[:success] = I18n.t('reviews.create.success')
    else
      render 'book/show'
    end
  end
  
  private
  
  def set_book
    @book = Book.find(params[:book_id])
  end
  
  def review_params
    params.require(:review).permit(:score, :title, :message).merge(user: current_user, book: @book)
  end
end
