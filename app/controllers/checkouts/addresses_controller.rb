module Checkouts
  class AddressesController < MasterController
    ADDRESS_ATTRIBUTES = %i[first_name last_name address city zip country phone id].freeze

    private

    def checkout_params
      params.required(:checkout).permit(
        :use_billing_address,
        billing_address_attributes: ADDRESS_ATTRIBUTES,
        shipping_address_attributes: ADDRESS_ATTRIBUTES
      ).merge(stage: Checkout::STAGES[:address])
    end
  end
end