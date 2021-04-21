module BooksHelper
  VISIBLE_LENGTH_DESCRIPTION_BOOK = 100
  
  def book_authors(book)
    book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def book_dimensions(book)
    "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}\""
  end
  
  def short_book_description(book)
    book.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end
end
