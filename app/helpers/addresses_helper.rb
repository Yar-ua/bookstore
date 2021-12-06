module AddressesHelper
  def create_or_update(params)
    if Address.exists?(user_id: current_user.id, address_type: params[:address_type])
      Address.where(user_id: current_user.id, address_type: params[:address_type]).update(params)
    else
      current_user.addresses.create(params)
    end
  end
end
