require 'rails_helper'

RSpec.describe 'Author section', type: :feature, js: true do
  let!(:admin_user) { create(:admin_user) }
  let!(:author) { create(:author) }

  before do
    login_as admin_user
    visit admin_authors_path
  end

  it { expect(page).to have_current_path('/admin/authors') }

  context 'when click view on the column' do
    before do
      click_link('View')
    end

    context 'when has correct content' do
      it { expect(page).to have_content(author.first_name) }
      it { expect(page).to have_content(author.last_name) }
      it { expect(page).to have_content(author.biography) }
    end
  end

  context 'when click edit on the column' do
    before do
      click_link('Edit')
    end

    it { expect(page).to have_content('Edit Author') }
    it { expect(page).to have_selector 'li', id: 'author_submit_action' }

    context 'when enter data' do
      before do
        fill_in 'author[first_name]', with: first_name
        fill_in 'author[last_name]', with: last_name
        find('li', id: 'author_submit_action').click
      end

      context 'when enter valid data and save changes' do
        let(:success_message) { 'Author was successfully updated.' }
        let(:first_name) { FFaker::Name.first_name }
        let(:last_name) { FFaker::Name.last_name }

        it { expect(page).to have_content(success_message) }
      end

      context 'when enter invalid data and save changes' do
        let(:error_message) { "can't be blank" }
        let(:first_name) { '' }
        let(:last_name) { '' }

        it { expect(page).to have_content(error_message) }
      end
    end
  end

  context 'when click create on the column' do
    before do
      click_link('New Author')
    end

    it { expect(page).to have_content('New Author') }
    it { expect(page).to have_selector 'li', id: 'author_submit_action' }

    context 'when enter data' do
      before do
        fill_in 'author[first_name]', with: first_name
        fill_in 'author[last_name]', with: last_name
        find('li', id: 'author_submit_action').click
      end

      context 'when enter valid data' do
        let(:success_message) { 'Author was successfully created.' }
        let(:first_name) { FFaker::Name.first_name }
        let(:last_name) { FFaker::Name.last_name }

        it { expect(page).to have_content(success_message) }
      end

      context 'when enter invalid data' do
        let(:error_message) { "can't be blank" }

        let(:first_name) { '' }
        let(:last_name) { '' }

        it { expect(page).to have_content(error_message) }
      end
    end
  end
end
