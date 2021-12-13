module Checkouts
  class LoginsController < ApplicationController
    before_action :authenticate_user!

    def show
      set_user_for_cart
      if user_signed_in? && @cart.user_id.present?
        redirect_to checkouts_address_path
      else
        raise StandardError, 'Error: user id not set for current cart'
        redirect_to root_path
      end
    end

    private

    def set_user_for_cart
      @cart = shopping_cart.current_cart
      @cart.user = current_user
      @cart.save
    end
  end
end
