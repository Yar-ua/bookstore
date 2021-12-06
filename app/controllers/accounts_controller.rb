class AccountsController < ApplicationController
  before_action :authenticate_user!

  def update
    change_password = ChangePasswordService.new(current_user, params).call
    if change_password
      flash[:success] = I18n.t('settings.changed_password')
    else
      flash[:error] = I18n.t('settings.wrong_password')
    end
    bypass_sign_in(current_user)
    redirect_to new_setting_path
  end

  def destroy
    flash[:success] = I18n.t('settings.deleted_account') if current_user&.destroy
    redirect_to root_path
  end
end
