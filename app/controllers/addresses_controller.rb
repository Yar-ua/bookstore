class AddressesController < ApplicationController
  include AddressesHelper
  before_action :authenticate_user!

  def create
    create_or_update(address_params)
    redirect_to new_setting_path
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type)
  end
end
