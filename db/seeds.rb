require 'ffaker'

users = FactoryBot.create_list(:user, 10)

CATEGORIES.each do |category|
  FactoryBot.create(:category, name: category)
end

FactoryBot.create_list(:author, 40)
100.times { FactoryBot.create(:book, :with_images, category_id: Category.all.sample.id) }

Book.all.each do |book|
  3.times do
    AuthorBook.create!(author_id: Author.all.sample.id, book_id: book.id)
  end
  FactoryBot.create_list(:review, rand(3..10), book: book, user: users.sample)
end

FactoryBot.create_list(:coupon, 50)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
