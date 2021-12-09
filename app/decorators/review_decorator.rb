class ReviewDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  STAR_RATING_CLASSNAMES = {
    active: 'fa fa-star rate-star',
    inactive: 'fa fa-star rate-empty'
  }.freeze

  def formatted_created_at
    created_at.strftime('%m/%d/%y')
  end

  def star_rating
    h.safe_join(star_tags)
  end

  def status_name
    h.t("reviews.status.#{status}")
  end

  private

  def star_tags
    Review::SCORE_RANGE.map do |index|
      h.tag.i(class: index <= score ? STAR_RATING_CLASSNAMES[:active] : STAR_RATING_CLASSNAMES[:inactive])
    end
  end
end
