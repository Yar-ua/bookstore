class SortBooks < ApplicationController
  SORT_OPTIONS = {
    newest: { title: I18n.t('sort.newest'), order: :created_at, by: :desc },
    popular: { title: I18n.t('sort.popular'), order: :created_at, by: :asc },
    price_low_high: { title: I18n.t('sort.price_low_high'), order: :price, by: :asc },
    price_high_low: { title: I18n.t('sort.price_high_low'), order: :price, by: :desc },
    title_a_z: { title: I18n.t('sort.title_a_z'), order: :title, by: :asc },
    title_z_a: { title: I18n.t('sort.title_z_a'), order: :title, by: :desc }
  }.freeze

  def sort(params)
    scoped = filter_by_category(params[:category_id])
    sort_books(scoped, params[:sort])
  end

  def current_sort(params)
    params[:sort].present? ? sort_key(params[:sort]) : sort_option(:newest)
  end

  private

  def filter_by_category(category_id)
    category_id.present? ? Book.where(category_id: category_id) : Book.all
  end

  def sort_books(scoped, query = nil)
    query ? scoped.order(sort_key(query)[:order] => sort_key(query)[:by]) : scoped
  end

  def sort_key(query)
    sort_option(query.to_sym)
  end

  def sort_option(key)
    SORT_OPTIONS[key]
  end
end
