class BookDecorator < Draper::Decorator
  delegate_all
  
  VISIBLE_LENGTH_DESCRIPTION_BOOK = 250
  
  def book_authors
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
  
  def dimensions
    "H: #{object.height}\" x W: #{object.width}\" x D: #{object.depth}\""
  end

  def short_description
    object.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end
  
  def big_description_length
    object.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end
end
