class OrdersController < ApplicationController
  helper_method :filter_presenter
  before_action :authenticate_user!

  def index
    @orders = Order.filter_by_user_status(current_user, params[:status]).decorate
  end

  def show
    @order = Order.find_by!(id: params[:id], user: current_user).decorate
  end

  private

  def filter_presenter
    @filter_presenter ||= OrdersFilterPresenter.new(params)
  end
end