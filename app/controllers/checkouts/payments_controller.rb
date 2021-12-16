module Checkouts
  class PaymentsController < MasterController
    private

    def update_checkout(attributes)
      attributes[:credit_card_attributes][:user] = current_user
      super
    end

    def checkout_params
      params.required(:checkout).permit(credit_card_attributes: %i[number cardholder_name expiration_date cvv])
            .merge(stage: Checkout::STAGES[:payment])
    end
  end
end
