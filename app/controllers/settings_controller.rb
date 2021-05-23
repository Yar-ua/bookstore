class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address
  
  def new
  end
  
  def create
    @address = Address.new(address_params)
  end
  
  private
  
  def set_address
    @billing_address = Address.where(user_id: current_user.id, address_type: 0)
    @shipping_address = Address.where(user_id: current_user.id, address_type: 0)
    puts @address
    render new_setting_path
  end
  
  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type)
  end
end
