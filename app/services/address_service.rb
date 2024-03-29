class AddressService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def type
    @params[:address_type]
  end

  def address_type
    "#{(@params[:address_type]).to_s.capitalize}Address"
  end

  def filter_params
    filter_params = @params.clone
    filter_params.delete(:address_type)
    filter_params
  end
end
