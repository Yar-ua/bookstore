class ApplicationController < ActionController::Base
  before_action :set_categories
  helper_method :shopping_cart

  def set_categories
    @categories = Category.order(:name)
  end

  private

  def shopping_cart
    @shopping_cart ||= ShoppingCartService.new(session, current_user)
  end
end
