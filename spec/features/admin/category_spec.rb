require 'rails_helper'

RSpec.describe 'Category section', type: :feature, js: true do
  let!(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    login_as admin_user
    visit admin_category_books_path
  end

  it { expect(page).to have_current_path('/admin/category_books') }

  context 'when click view on the column' do
    before do
      click_link('View')
    end

    it { expect(page).to have_content(category.name) }
  end

  context 'when click edit on the column' do
    before do
      click_link('Edit')
    end

    it { expect(page).to have_content('Edit Category') }
    it { expect(page).to have_selector 'li', id: 'category_submit_action' }

    context 'when enter valid data and save changes' do
      let(:success_message) { 'Category was successfully updated.' }

      before do
        fill_in 'category[name]', with: FFaker::Book.genre
        find('li', id: 'category_submit_action').click
      end

      it { expect(page).to have_content(success_message) }
    end

    context 'when enter invalid data and save changes' do
      let(:error_message) { "can't be blank" }

      before do
        fill_in 'category[name]', with: ''
        find('li', id: 'category_submit_action').click
      end

      it { expect(page).to have_content(error_message) }
    end
  end

  context 'when click create on the column' do
    before do
      click_link('New Category')
    end

    it { expect(page).to have_content('New Category') }
    it { expect(page).to have_selector 'li', id: 'category_submit_action' }

    context 'when enter valid data' do
      let(:success_message) { 'Category was successfully created.' }

      before do
        fill_in 'category[name]', with: FFaker::Book.genre
        find('li', id: 'category_submit_action').click
      end

      it { expect(page).to have_content(success_message) }
    end

    context 'when enter invalid data' do
      let(:error_message) { "can't be blank" }

      before do
        find('li', id: 'category_submit_action').click
      end

      it { expect(page).to have_content(error_message) }
    end
  end
end
