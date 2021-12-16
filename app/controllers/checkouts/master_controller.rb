module Checkouts
  class MasterController < ApplicationController
    STEPS = %w[address delivery payment confirm complete].freeze
    CHECKOUT_SESSION_ID = :checkout_id

    before_action :authenticate_user!
    before_action :set_cart, if: :require_cart?
    before_action :set_checkout, if: :require_checkout?

    helper_method :steps

    def show; end

    def update
      if update_checkout(checkout_params)
        redirect_to next_step_path
      else
        render :show
      end
    end

    private

    def checkout_params
      {}
    end

    def update_checkout(attributes)
      @checkout.update(attributes)
    end

    def load_checkout
      Checkout.find(session[CHECKOUT_SESSION_ID])
    rescue ActiveRecord::RecordNotFound
      checkout = CheckoutFactoryService.new(current_user).create_checkout!
      session[CHECKOUT_SESSION_ID] = checkout.id
      checkout
    end

    def set_checkout
      @checkout = load_checkout.decorate
    end

    def set_cart
      @cart = shopping_cart.current_cart.decorate
      redirect_to edit_cart_path if @cart.empty?
    end

    def next_step
      STEPS[current_step_index.next]
    end

    def next_step_path
      method_name = :"checkouts_#{next_step}_path"
      method(method_name).call if respond_to?(method_name)
    end

    def current_step
      controller_name.singularize
    end

    def current_step_index
      STEPS.index(current_step)
    end

    def steps
      @steps ||= CheckoutStepsPresenter.new(STEPS, current_step).call
    end

    def require_checkout?
      true
    end

    def require_cart?
      true
    end
  end
end
