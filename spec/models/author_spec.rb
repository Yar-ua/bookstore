RSpec.describe Author do
  describe 'with database columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:biography).of_type(:text) }
  end

  describe 'with assosiations' do
    it { is_expected.to have_many(:authorships) }
    it { is_expected.to have_many(:books).through(:authorships).dependent(:destroy) }
  end
end
