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
      clear_id(@parameters[:billing_address_attributes]) if @parameters[:billing_address_attributes].present?
      clear_id(@parameters[:shipping_address_attributes]) if @parameters[:shipping_address_attributes].present?
      #   @parameters[:billing_address_attributes].delete(:id) if !@parameters[:billing_address_attributes][:id].nil?
      # end
      # if @parameters[:shipping_address_attributes].present?
      #   @parameters[:shipping_address_attributes].delete(:id) if !@parameters[:shipping_address_attributes][:id].nil?
      # end
    end

    def clear_id(hash)
      hash.delete(:id) unless hash[:id].nil?
    end
  end
end
