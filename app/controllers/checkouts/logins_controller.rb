module Checkouts
  class LoginsController < MasterController
    before_action :authenticate_user!

    def show
      set_user_for_cart unless @cart.user_id.present?

      if user_signed_in? && @cart.user_id.present?
        flash[:success] = I18n.t('checkouts.user_setted_for_card')
        redirect_to checkouts_address_path
      else
        flash[:error] = I18n.t('checkouts.user_card_error')
        redirect_to edit_cart_path
      end
    end

    private

    def require_cart?
      true
    end

    def require_checkout?
      false
    end

    def set_user_for_cart
      @cart.user = current_user
      @cart.save
    end
  end
end
