require 'ffaker'

CATEGORIES.each do |category|
  FactoryBot.create(:category, name: category)
end

FactoryBot.create_list(:author, 40)
100.times { FactoryBot.create(:book, category_id: Category.all.sample.id) }

Book.all.each do |book|
  3.times do
    AuthorBook.create!(author_id: Author.all.sample.id, book_id: book.id)
  end
end
