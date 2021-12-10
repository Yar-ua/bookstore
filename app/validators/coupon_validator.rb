class CouponValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    coupon = Coupon.find_by(code: value)
    record.errors.add(attribute, I18n.t('activerecord.errors.messages.invalid_coupon')) unless coupon
  end
end