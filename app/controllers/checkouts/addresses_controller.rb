module Checkouts
  class AddressesController < MasterController
    ADDRESS_ATTRIBUTES = %i[first_name last_name address city zip country phone id].freeze

    private

    def checkout_params
      form_params
      filter_id_params
      @parameters
    end
    
    def form_params
      @parameters = params.required(:checkout).permit(
          :use_billing_address,
          billing_address_attributes: ADDRESS_ATTRIBUTES,
          shipping_address_attributes: ADDRESS_ATTRIBUTES
        ).merge(stage: Checkout::STAGES[:address])
    end
    
    def filter_id_params
      @parameters[:billing_address_attributes].delete(:id)
      @parameters[:shipping_address_attributes].delete(:id)
    end
  end
end