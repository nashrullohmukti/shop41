class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :name, :address, :email, presence: true
  enum pay_type: {
    "Check" => 0,
    "Credit card" => 1,
    "Purchase order" => 2
  }
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  def total_product
    line_items.to_a.sum { |item| item.quantity }
  end

  def paypal_url(cart,order,return_path)
    @cart = cart
    @order = order
    total = @cart.total_price
    values = {
      business: "merchant@nasrul.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: "#{total}",
      item_name: "Please Check Your Email For Detail All Of Your Order",
      item_number: "#{@cart.total_product}",
      quantity: "1",
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
