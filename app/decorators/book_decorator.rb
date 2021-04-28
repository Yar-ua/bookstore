class BookDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all
  decorates_association :authors

  VISIBLE_LENGTH_DESCRIPTION_BOOK = 250

  def book_authors
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    I18n.t('book.dimensions_h_w_s', height: object.height, width: object.width, depth: object.depth)
  end

  def short_description
    object.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end

  def big_description_length?
    object.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end

  def price_to_currency
    number_to_currency(object.price, unit: I18n.t('catalog.currency'))
  end
end
