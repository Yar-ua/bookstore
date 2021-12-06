class AddressesController < ApplicationController
  include AddressesHelper
  before_action :authenticate_user!

  def create
    flash[:success] = I18n.t('settings.address_was_changed') if create_or_update(address_params)
    redirect_to new_setting_path
  end

  private

  def address_params
    params.require(:billing || :shipping).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone,
                                                 :address_type)
  end
end
