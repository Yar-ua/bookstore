class AddressesController < ApplicationController
  include AddressesHelper
  before_action :authenticate_user!

  def create
    flash[:success] = I18n.t('settings.address_was_changed') if create_or_update(address_params)
    redirect_to new_setting_path
  end

  private

  def address_params
    params.require(address_form_type).permit(:first_name, :last_name, :address, 
                                         :city, :zip, :country, :phone, :address_type)
  end
  
  def address_form_type
    params[:billing_form].present? ? :billing_form : :shipping_form
  end
end
