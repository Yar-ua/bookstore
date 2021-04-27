class PagesController < ApplicationController
  LAST_BOOKS_QUANTITY = 3
  BEST_SELLERS_QUANTITY = 4

  def index
    @categories = Category.all
    @last_books = BookDecorator.decorate_collection(Book.last(LAST_BOOKS_QUANTITY))
    @best_sellers = Book.all.decorate.sample(BEST_SELLERS_QUANTITY)
  end
end
