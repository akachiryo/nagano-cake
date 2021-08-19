class OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def index
    @orders = Order.all
  end
  
  def show
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
  end
  
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to complete_orders_path
    else
      render "/"
    end
  end
  
  def complete
  end

  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postcode, :address, :name, :payment, :total_payment, :delivery_fee)
  end

end