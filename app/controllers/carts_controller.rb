class CartsController < ApplicationController
  before_action :set_cart

  def edit; end

  def update
    respond_to do |format|
      if shopping_cart.update(cart_params)
        format.html { redirect_to edit_cart_path }
      else
        format.html { render :edit }
      end
      format.js
    end
  end

  private

  def set_cart
    @cart = shopping_cart.current_cart.decorate
  end

  def cart_params
    params.required(:cart).permit(:coupon_code, line_items_attributes: %i[id quantity _destroy])
  end
end
