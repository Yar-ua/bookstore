RSpec.describe Category do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:books_count).of_type(:integer) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end
end
