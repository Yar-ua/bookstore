module SettingsHelper
  def get_address_by_type(type)
    Address.exists?(user_id: current_user.id, address_type: type) ? Address.where(user_id: current_user.id, address_type: type)[0] : Address.new
  end
end
