class AddressesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @address = current_user.addresses.build(address_params)
    puts @address.inspect
    @address.save
    # puts '=======---------***********'
    # puts @address
    redirect_to new_setting_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type)
  end
end
