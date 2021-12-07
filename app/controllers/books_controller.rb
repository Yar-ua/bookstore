class BooksController < ApplicationController
  include Pagy::Backend
  before_action :set_sort_data, only: :index

  def index
    @pagy, @books = pagy(BooksQuery.new(sort_params).call, class: 'btn btn-primary')
    @books = @books.decorate.to_a
    respond_to do |format|
      format.html
      format.js { render 'index.js.haml', layout: false }
    end
  end

  def show
    @book = Book.find(params[:id]).decorate
    gon.bookQuantity = @book.quantity
  end

  private

  def sort_params
    params.permit(:category_id, :sort)
  end

  def set_sort_data
    @sort_list = BooksQuery::SORT_OPTIONS
    @current_sort = SortQuery.new(sort_params).call
    return @current_category = Category.find(params[:category_id]) if params[:category_id]

    @current_category = Category.new(id: nil, name: I18n.t('categories.all'))
  end
end
