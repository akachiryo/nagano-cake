class OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    
    @order = Order.new(order_params)
    
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @order.postcode = current_customer.postcode
    @order.address = current_customer.address
    @order.name = current_customer.first_name
    @order.total_payment = @cart_items.items_of_price
    @order.delivery_fee = 800
  
  end
  
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to complete_orders_path
    else
      render "/"
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postcode, :address, :name, :payment, :total_payment, :delivery_fee)
  end

end