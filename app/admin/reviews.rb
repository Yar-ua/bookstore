ActiveAdmin.register Review do
  actions :show, :index

  decorate_with ReviewDecorator
  includes :book, :user

  scope :unprocessed
  scope :approved
  scope :rejected

  index do
    column :id
    column :book
    column :user
    column :title
    column :status do |review|
      status_tag review.status
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :book
      row :user
      row :score
      row :title
      row :message
      row :status do |review|
        status_tag review.status
      end
      row :created_at
      row :updated_at
    end
  end

  action_item :approve, only: :show, if: proc { !resource.approved? } do
    link_to I18n.t('active_admin.reviews.approve'), approve_admin_review_path(review),
            class: 'action-approve', method: :post
  end

  action_item :reject, only: :show, if: proc { !resource.rejected? } do
    link_to I18n.t('active_admin.reviews.reject'), reject_admin_review_path(review),
            class: 'action-reject', method: :post
  end

  member_action :approve, method: :post do
    resource.approved!
    redirect_to admin_review_path(resource), notice: I18n.t('active_admin.reviews.successfully_approved')
  end

  member_action :reject, method: :post do
    resource.rejected!
    redirect_to admin_review_path(resource), notice: I18n.t('active_admin.reviews.successfully_rejected')
  end
end
