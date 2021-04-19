module SortHelper
  SORT_OPTIONS = {
    newest: { title: 'Newest first', order: :created_at, by: :desc },
    popular: { title: 'Popular first', order: :created_at, by: :asc },
    price_low_high: { title: 'Price: Low to high', order: :price, by: :asc },
    price_high_low: { title: 'Price: High to low', order: :price, by: :desc },
    title_a_z: { title: 'Title: A-Z', order: :title, by: :asc },
    title_z_a: { title: 'Title: Z-A', order: :title, by: :desc }
  }.freeze
  private_constant :SORT_OPTIONS

  def sort_options
    SORT_OPTIONS
  end

  def sort_option(key)
    SORT_OPTIONS[key]
  end

  def sort_params(key)
    sort_params_hash = {}
    sort_params_hash[:sort] = key if key.present?
    sort_params_hash
  end
end
