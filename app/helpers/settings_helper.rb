module SettingsHelper
  def get_address_by_type(type)
    if Address.exists?(user_id: current_user.id,
                       address_type: type)
      Address.where(user_id: current_user.id, address_type: type)[0]
    else
      Address.new
    end
  end
end
