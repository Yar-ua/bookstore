require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { create(:address) }
  
  describe 'validation' do
    it { expect(address).to validate_presence_of(:first_name) }
    it { expect(address).to validate_presence_of(:last_name) }
    it { expect(address).to validate_presence_of(:address) }
    it { expect(address).to validate_presence_of(:city) }
    it { expect(address).to validate_presence_of(:country) }
    it { expect(address).to validate_presence_of(:zip) }
    it { expect(address).to validate_presence_of(:phone) }
  end
  
  describe 'with assosiations' do
    
    it { is_expected.to belong_to(:user) }
  end
end
