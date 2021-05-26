RSpec.describe Category do
  let(:author) { create(:category) }

  describe 'validation' do
    it { expect(author).to validate_presence_of(:name) }
    it { expect(author).to validate_length_of(:name) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end
end
