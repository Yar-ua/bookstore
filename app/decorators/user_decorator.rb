class UserDecorator < Draper::Decorator
  EMAIL_SPLIT_PATTERN = '@'.freeze

  delegate_all

  def avatar_letter
    email.first.upcase
  end
end
