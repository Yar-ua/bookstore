module Checkouts
  class CompletesController < MasterController
    def show
      @order = Order.where(user: current_user).first.decorate
    end

    private

    def require_cart?
      false
    end

    def require_checkout?
      false
    end
  end
end
