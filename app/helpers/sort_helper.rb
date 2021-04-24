module SortHelper
  def sort_params(sort, current_category_id)
    sort_hash(sort).merge(category_id: current_category_id)
  end
  
  def sort_hash(sort)
    { sort: sort.to_sym } if sort.present?
  end
end
