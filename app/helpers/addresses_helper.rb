module AddressesHelper
  def create_or_update(params)
    @address_service = AddressService.new(params, current_user)
    address = Address.find_by(user_id: current_user.id, type: @address_service.address_type)
    if address.present?
      address.update(@address_service.filter_params)
    else
      current_user.public_send("create_#{@address_service.type}_address", @address_service.filter_params)
    end
  end

  def get_address_by_type(type)
    address = current_user.public_send("#{type}_address")
    return address if address.present?

    # this method returns new object of BillingAddress or ShippingAddress classes
    # class name constructed from string classname
    (Object.const_get "#{type.to_s.capitalize}Address").new
  end
end
