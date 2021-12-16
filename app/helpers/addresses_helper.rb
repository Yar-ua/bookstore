module AddressesHelper
  def create_or_update(params)
    @address_service = AddressService.new(params, current_user)
    address = address_type(@address_service.type)
    if address.present?
      address.update(@address_service.filter_params)
    else
      current_user.public_send("create_#{@address_service.type}_address", @address_service.filter_params)
    end
  end

  def get_address(type)
    address = address_type(type)
    return address if address.present?

    construct_address_class(type)
  end

  def address_type(type)
    current_user.public_send("#{type}_address")
  end

  def construct_address_class(type)
    # this method returns new object of BillingAddress or ShippingAddress classes
    # class name constructed from string classname
    (Object.const_get "#{type.to_s.capitalize}Address").new
  end
end
