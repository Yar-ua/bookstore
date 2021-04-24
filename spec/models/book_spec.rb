RSpec.describe Book do
  describe 'with database columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:year).of_type(:integer) }
    it { is_expected.to have_db_column(:height).of_type(:decimal) }
    it { is_expected.to have_db_column(:width).of_type(:decimal) }
    it { is_expected.to have_db_column(:depth).of_type(:decimal) }
    it { is_expected.to have_db_column(:materials).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_index(:category_id) }
  end

  describe 'with assosiations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:authorships).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:authorships) }
  end
end
