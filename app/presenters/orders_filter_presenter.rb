class OrdersFilterPresenter
  include Rails.application.routes.url_helpers

  def initialize(params)
    @params = params
  end

  def selected_option
    options.find { |option| option[:selected] }
  end

  def options
    @options ||= status_options.prepend(all_option)
  end

  private

  def all_option
    { label: I18n.t('orders.status.all'), path: orders_path, selected: current_status.nil? }
  end

  def current_status
    @params['status'] if statuses.include?(@params['status'])
  end

  def status_options
    statuses.map do |status|
      { label: I18n.t("orders.status.#{status}"), path: orders_path(status: status),
        selected: status == current_status }
    end
  end

  def statuses
    @statuses ||= Order.aasm.states.map { |state| state.name.to_s }
  end
end