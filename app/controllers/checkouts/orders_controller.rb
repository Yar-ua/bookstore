module Checkouts
  class OrdersController < MasterController
    CURRENT_STEP = 'confirm'.freeze

    def create
      # binding.pry
      OrderFactoryService.new(@cart, @checkout).create_order!
      shopping_cart.empty
      destroy_checkout
      redirect_to next_step_path
    end

    private

    def current_step
      CURRENT_STEP
    end

    def destroy_checkout
      session.delete(CHECKOUT_SESSION_ID)
      @checkout.destroy
    end
  end
end