class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook]

  attr_accessor :skip_password_validation

  has_many :reviews, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :billing_address, :shipping_address

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, presence: true, length: { in: 6..20 }, unless: :skip_password_validation

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid,
                          email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end
end
