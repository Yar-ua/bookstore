class BookDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper
  delegate_all

  VISIBLE_LENGTH_DESCRIPTION_BOOK = 250

  def book_authors
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
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
