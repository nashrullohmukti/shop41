class HomeController < ApplicationController
  include CurrentCart
  protect_from_forgery except: [:hook]
  before_action :set_cart
  def index
    @products = Product.order(:name)
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find params[:invoice]
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end
end
