class SettingsEmailController < ApplicationController
  before_action :authenticate_user!

  def update
    skip_user_checks!
    if current_user.update_without_password(params.require(:user).permit(:email))
      flash[:success] = I18n.t('settings.email_changed')
    else
      flash[:error] = I18n.t('settings.error')
    end
    redirect_to new_setting_path
  end

  def skip_user_checks!
    current_user.skip_password_validation = true
    current_user.skip_confirmation!
    current_user.skip_reconfirmation!
  end
end
