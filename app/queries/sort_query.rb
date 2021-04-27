class SortQuery < BooksQuery
  def call
    @sort_params[:sort].present? ? sort_key(@sort_params[:sort]) : sort_option(:newest)
  end
end
