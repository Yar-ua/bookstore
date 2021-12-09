require 'rails_helper'
# require "rspec/expectations"

RSpec.describe 'Admin Reviews', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }

  before do
    login_as admin_user
    review
  end

  describe 'Show reviews' do
    before do
      visit admin_reviews_path
    end

    context 'when contains expected content' do
      it { expect(page).to have_content(review.book.title) }
      it { expect(page).to have_content(review.title) }
      it { expect(page).to have_content(review.user.email) }
      it { expect(page).to have_css('span', class: 'status_tag') }
    end
  end

  describe 'View a review' do
    before do
      visit admin_reviews_path
      find_link(href: "/admin/reviews/#{review.id}").click
    end

    it { expect(page).to have_current_path(admin_review_path(review)) }

    context 'when contains expected content' do
      it { expect(page).to have_content(review.title) }
      it { expect(page).to have_content(review.message) }
      it { expect(page).to have_content(review.user.email) }
      it { expect(page).to have_content(review.score) }
      it { expect(page).to have_css('span', class: "status_tag #{review.status}") }
    end
  end

  describe 'Approve a review' do
    let(:review) { create(:review, status: :unprocessed) }

    before do
      visit admin_review_path(review)
    end

    describe 'contains approve content' do
      before do
        find_link('Approve', class: 'action-approve').click
      end

      it { expect(page).to have_text(I18n.t('active_admin.reviews.successfully_approved')) }
      it { expect(Review.find(review.id).status).to eq('approved') }
    end

    describe 'contains reject content' do
      before do
        find_link('Reject', class: 'action-reject').click
      end

      it { expect(page).to have_text(I18n.t('active_admin.reviews.successfully_rejected')) }
      it { expect(Review.find(review.id).status).to eq('rejected') }
    end
  end
end
