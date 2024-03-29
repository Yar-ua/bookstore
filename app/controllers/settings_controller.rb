class SettingsController < ApplicationController
  include AddressesHelper
  before_action :authenticate_user!
  before_action :set_address

  def new; end

  private

  def set_address
    @billing_address = get_address(:billing)
    @shipping_address = get_address(:shipping)
  end
end
