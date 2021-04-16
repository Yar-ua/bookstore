module BooksHelper
  def book_authors(book)
    book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
