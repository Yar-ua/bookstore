class SettingsController < ApplicationController
  include SettingsHelper
  before_action :authenticate_user!
  before_action :set_address
  
  def new
  end
  
  private
  
  def set_address
    @billing_address = get_address_by_type(:billing)
    @shipping_address = get_address_by_type(:shipping)
  end
end
