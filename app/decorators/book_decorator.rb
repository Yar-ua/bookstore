class BookDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all
  decorates_association :authors
  decorates_association :approved_reviews

  VISIBLE_LENGTH_DESCRIPTION_BOOK = 250

  def book_authors
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    I18n.t('book.dimensions', height: object.height, width: object.width, depth: object.depth)
  end

  def short_description
    object.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end

  def short_description_with_dots
    short_description + I18n.t('book.dots')
  end

  def big_description_length?
    object.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end

  def price_to_currency
    number_to_currency(object.price, unit: I18n.t('catalog.currency'))
  end

  def general_image
    images.first
  end

  def general_image_thumb
    general_image&.variant({ resize_to_limit: [250, 400] })
  end

  def images_gallery_thumbs
    images.map { |image| [image, image.variant({ resize_to_limit: [150, 240] })] }
  end

  def admin_general_image
    h.image_tag(general_image.variant(resize_to_limit: [100, 100])) if general_image
  end

  def admin_images
    tags = images.map { |image| h.image_tag(image.variant(resize_to_limit: [100, 100])) }
    h.safe_join(tags)
  end
end
