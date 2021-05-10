class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, presence: true, length: { in: 6..20 }

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    return user if user
    user = User.new(provider: auth.provider, uid: auth.uid,
                          email: auth.info.email, password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user
  end
end
