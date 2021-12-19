ActiveAdmin.register Order do
  actions :all, except: %i[update edit new destroy]
  decorate_with OrderDecorator
  includes :user

  scope :in_progress
  scope :in_queue
  scope :in_delivery
  scope :delivered
  scope :canceled

  index do
    column :number
    column :created_at
    column :status do |order|
      status_tag order.status_name
    end
    actions
  end

  show do
    attributes_table do
      row :number
      row :user
      row :total_format
      row :status do |order|
        status_tag order.status_name
      end
      row :line_items do |order|
        render partial: 'line_items', order: order
      end
      row :created_at
      row :updated_at
      row :completed_at
    end
  end

  action_item :pay, only: :show, if: proc { resource.in_progress? } do
    link_to I18n.t('active_admin.orders.pay'), pay_admin_order_path(order),
            class: 'action-deliver', method: :post
  end

  action_item :deliver, only: :show, if: proc { resource.in_queue? } do
    link_to I18n.t('active_admin.orders.deliver'), deliver_admin_order_path(order),
            class: 'action-deliver', method: :post
  end

  action_item :complete, only: :show, if: proc { resource.in_delivery? } do
    link_to I18n.t('active_admin.orders.complete'), complete_admin_order_path(order),
            class: 'action-cancel', method: :post
  end

  action_item :cancel, only: :show, if: proc { !resource.delivered? } do
    link_to I18n.t('active_admin.orders.cancel'), cancel_admin_order_path(order),
            class: 'action-cancel', method: :post
  end

  member_action :pay, method: :post do
    resource.pay!
    redirect_to admin_order_path(resource), notice: I18n.t('active_admin.orders.successfully_delivering')
  end

  member_action :deliver, method: :post do
    resource.deliver!
    redirect_to admin_order_path(resource), notice: I18n.t('active_admin.orders.successfully_delivering')
  end

  member_action :complete, method: :post do
    resource.complete!
    redirect_to admin_order_path(resource), notice: I18n.t('active_admin.orders.successfully_delivered')
  end

  member_action :cancel, method: :post do
    resource.cancel!
    redirect_to admin_order_path(resource), notice: I18n.t('active_admin.orders.successfully_canceled')
  end
end
