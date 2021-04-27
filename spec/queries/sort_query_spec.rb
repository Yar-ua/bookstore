RSpec.describe SortQuery do
  let(:sort_books) { described_class }

  describe 'current sorting' do
    it {
      expect(described_class.new(sort: :newest).call).to eq({ title: I18n.t('sort.newest'), order: :created_at,
                                                              by: :desc })
    }

    it {
      expect(described_class.new(sort: :price_low_high).call).to eq({ title: I18n.t('sort.price_low_high'),
                                                                      order: :price, by: :asc })
    }
  end
end
