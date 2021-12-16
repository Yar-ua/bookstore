class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]
    @user = params[:user]

    mail(to: @user.email, subject: t('.new_order', order_id: @order.id))
  end
end
