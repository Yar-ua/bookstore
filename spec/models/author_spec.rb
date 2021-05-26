RSpec.describe Author do
  let(:author) { FactoryBot.create(:author) }

  describe 'validation' do
    it { expect(author).to validate_presence_of(:first_name) }
    it { expect(author).to validate_presence_of(:last_name) }
    it { expect(author).to validate_length_of(:first_name) }
    it { expect(author).to validate_length_of(:last_name) }
  end

  describe 'with assosiations' do
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to have_many(:books).through(:author_books).dependent(:destroy) }
  end
end
