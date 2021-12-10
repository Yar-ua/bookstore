class BookPage < SitePrism::Page
  set_url '/books{/id}'

  section :header, HeaderSection
  section :footer, FooterSection
  section :product_counter, ProductCounterSection
  section :review_form, ReviewFormSection
  sections :reviews, ReviewSection, '.general-message-wrap'

  element :heading, 'h1'
  element :authors, :xpath, '(//p[contains(@class, "lead")])[1]'
  element :description, :xpath, '(//p[contains(@class, "lead")])[2]'
  element :publication_year, :xpath, '(//p[contains(@class, "lead")])[3]'
  element :dimensions, :xpath, '(//p[contains(@class, "lead")])[4]'
  element :materials, :xpath, '(//p[contains(@class, "lead")])[5]'
  element :read_more, '.read-more'

  element :gallery_image, '.product-gallery__image'
  elements :gallery_thumbs, '.product-gallery__thumbs img'

  element :alert, '.alert-danger'
  element :notice, '.alert-success'
end
