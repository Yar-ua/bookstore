require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  let(:omniauth_user) { attributes_for(:user) }

  it { expect(user).to validate_presence_of(:email) }
  it { expect(user).to validate_presence_of(:password) }
  it { is_expected.to have_many(:reviews) }

  describe 'user from omniauth' do
    let(:auth) { @auth = OmniAuth.config.mock_auth[:facebook] }

    before do
      OmniAuth.config.add_mock(:facebook,
                               { provider: 'facebook',
                                 uid: FFaker::Code.ean,
                                 info: { first_name: FFaker::Name.first_name,
                                         name: FFaker::Name.last_name,
                                         email: FFaker::Internet.email },
                                 credentials: { expires_at: FFaker::Code.npi,
                                                token: FFaker::Code.npi } })
    end

    it 'create new user' do
      described_class.from_omniauth(auth)
      expect(described_class.where(uid: auth.uid)[0].email).to eq(auth.info.email)
    end
  end

  describe 'with assosiations' do
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
  end
end
