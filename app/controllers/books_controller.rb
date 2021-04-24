class BooksController < ApplicationController
  include Pagy::Backend

  before_action :set_book, only: :show
  before_action :set_categories, only: %i[index show]
  before_action :set_current_category, :set_current_sort, :set_sort_list, only: :index

  def index
    @sort_books = SortBooks.new
    @pagy, @books = pagy(@sort_books.sort(sort_params), class: 'btn btn-primary')
    @books = @books.decorate
    respond_to do |format|
      format.html
      format.js { render 'index.js.haml', layout: false }
    end
  end

  def show; end

  private
  
  def sort_params
    params.permit(:category_id, :sort)
  end

  def set_book
    @book = Book.find(params[:id]).decorate
  end

  def set_categories
    @categories = Category.order(:name)
  end

  def set_current_category
    return @current_category = Category.find(params[:category_id]) if params[:category_id]

    @current_category = Category.new(id: nil, name: 'All')
  end

  def set_current_sort
    @current_sort = SortBooks.new.current_sort(sort_params)
  end
  
  def set_sort_list
    @sort_list = SortBooks::SORT_OPTIONS
  end
end
