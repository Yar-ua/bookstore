class AuthorDecorator < ApplicationDecorator
  delegate_all

  def sss
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
