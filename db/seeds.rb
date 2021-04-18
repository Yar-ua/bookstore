require 'faker'

FactoryBot.create(:category, name: 'Mobile Development')
FactoryBot.create(:category, name: 'Photo')
FactoryBot.create(:category, name: 'Web Design')
FactoryBot.create(:category, name: 'Web Development')

40.times { FactoryBot.create(:author) }

100.times do
  FactoryBot.create(:book, category_id: Category.all.sample.id)
end

Book.all.each do |book|
  3.times do
    Authorship.create!(author_id: Author.all.sample.id, book_id: book.id)
  end
end
