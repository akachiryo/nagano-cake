class OrdersController < ApplicationController
    
def new
@order = Order.new
@customer = Customer.find(current_customer.id)
@addresses = @customer.addresses
end

def create 
 
  @order = Order.new(order_params)
end

def confirm
  @order=Order.new(order_params)
  @cart_items= CartItem.all  
  @cart_item=CartItem.new
  @order.shipping_cost ="800"
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
 
end

def complete
end



private

def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
end


    
end