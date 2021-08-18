class OrdersController < ApplicationController
    
def new
  @order = Order.new
  @customer = Customer.find(current_customer.id)
  @addresses = Address.all
end

def create 
  @order = Order.new(order_params)
end

def confirm
  @order = Order.new(order_params)
  @cart_items= current_customer.cart_items.all  
end

def complete
end



private

def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
end


    
end