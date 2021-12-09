require 'rails_helper'

RSpec.describe 'Author section', type: :feature, js: true do
  let!(:admin_user) { create(:admin_user) }
  let!(:book) { create(:book, category_id: category.id, material: 0) }
  let!(:category) { create(:category) }
  let(:author) { create(:author) }
  let(:material) { rand(0..2) }

  before do
    login_as admin_user
    visit admin_books_path
  end

  it { expect(page).to have_current_path('/admin/books') }

  context 'when click view on the column' do
    before do
      click_link('View')
    end

    context 'when has correct content' do
      it { expect(page).to have_content(book.title) }
      it { expect(page).to have_content(book.description) }
      it { expect(page).to have_content(book.year) }
      it { expect(page).to have_content(book.price) }
      it { expect(page).to have_content(book.height) }
      it { expect(page).to have_content(book.width) }
      it { expect(page).to have_content(book.depth) }
      it { expect(page).to have_content(book.material) }
    end

    context 'when click on category' do
      before do
        click_link category.name
      end

      it { expect(page).to have_current_path admin_category_book_path(category.id) }
    end
  end

  context 'when click edit on the column' do
    before do
      click_link('Edit')
    end

    it { expect(page).to have_content('Edit Book') }
    it { expect(page).to have_selector 'li', id: 'book_submit_action' }

    context 'when enter valid data and save changes' do
      let(:success_message) { 'Book was successfully updated.' }

      before do
        select category.name, from: 'book[category_id]'
        fill_in 'book[title]', with: FFaker::Book.title
        fill_in 'book[description]', with: FFaker::Book.description
        fill_in 'book[quantity]', with: rand(1..100)
        fill_in 'book[year]', with: rand(1980..2021)
        fill_in 'book[height]', with: rand(6.4..10.0)
        fill_in 'book[width]', with: rand(4.4..8.0)
        fill_in 'book[depth]', with: rand(0.5..2.0)
        find('li', id: 'book_submit_action').click
      end

      it { expect(page).to have_content(success_message) }
    end

    context 'when enter invalid data and save changes' do
      let(:error_message) { "can't be blank" }

      before do
        fill_in 'book[title]', with: ''
        find('li', id: 'book_submit_action').click
      end

      it { expect(page).to have_content(error_message) }
    end
  end

  context 'when click create on the column' do
    before do
      click_link('New Book')
    end

    it { expect(page).to have_content('New Book') }
    it { expect(page).to have_selector 'li', id: 'book_submit_action' }

    context 'when enter valid data' do
      let(:success_message) { 'Book was successfully created.' }

      before do
        select category.name, from: 'book[category_id]'
        fill_in 'book[title]', with: FFaker::Book.title
        find(id: 'book_author_ids').set(true)
        fill_in 'book[description]', with: FFaker::Book.description
        fill_in 'book[quantity]', with: rand(1..100)
        fill_in 'book[year]', with: rand(1980..2021)
        fill_in 'book[height]', with: rand(6.4..10.0)
        fill_in 'book[width]', with: rand(4.4..8.0)
        fill_in 'book[depth]', with: rand(0.5..2.0)
        find(id: 'book_materials_input', text: 'silk').set(true)
        fill_in 'book[price]', with: rand(1..100)
        find('li', id: 'book_submit_action').click
      end

      it { expect(page).to have_content(success_message) }
    end

    context 'when enter invalid data' do
      let(:error_message) { "can't be blank" }

      before do
        find('li', id: 'book_submit_action').click
      end

      it { expect(page).to have_content(error_message) }
    end
  end
end
