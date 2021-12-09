class ReviewFormSection < SitePrism::Section
  set_default_search_arguments '#new_review'

  elements :stars, '.review_score .fa-star'
  element :title_field, '#review_title'
  element :message_field, '#review_message'
  element :submit_button, '[type="submit"]'
  elements :errors, '.has-error .help-block'

  def select_score(score)
    stars[score - 1].click
  end

  def submit
    submit_button.click
  end
end
