class BooksController < ApplicationController
  include Pagy::Backend
  include SortHelper

  before_action :set_book, only: :show
  before_action :set_categories, only: %i[index show]
  before_action :set_current_category, only: :index
  before_action :set_current_sort, only: :index

  def index
    @pagy, @books = pagy(set_and_sort_books, class: 'btn btn-primary')
    respond_to do |format|
      format.html
      format.js { render 'index.js.haml', layout: false }
    end
  end

  def show
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_categories
    @categories = Category.order(:name)
  end

  def set_current_category
    return @current_category = Category.find(params[:category_id]) if params[:category_id]

    @current_category = Category.new(id: nil, name: 'All')
  end

  def set_current_sort
    @current_sort = params[:sort].present? ? sort_key : sort_option(:newest)
  end

  def set_and_sort_books
    books = params[:category_id].present? ? Book.where(category_id: params[:category_id]) : Book.all
    books = books.order(sort_key[:order] => sort_key[:by]) if params[:sort]
    books
  end

  def sort_key
    sort_option(params[:sort].to_sym)
  end
end
