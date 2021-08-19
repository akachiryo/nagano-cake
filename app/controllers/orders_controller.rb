class OrdersController < ApplicationController
    
def new
  @order = Order.new
  @addresses = current_customer.addresses
end

def confirm
  @order = Order.new(order_params)
  @cart_items = current_customer.cart_items
  @order.customer_id = current_customer.id
  @order.shipping_cost = 800
  @total_payment = @order.shipping_cost + @cart_items.items_of_price
  @registered_address = Address.where(id: current_customer.id)
end

def create 
 @order = Order.new(order_params)
 @cart_items = current_customer.cart_items
 if @order.save
   @cart_items.each do |cart_item|
     @order_detail = OrderDetail.new
     @order_detail.order_id = @order.id
     @order_detail.item_id = cart_item.item.id
     @order_detail.amount = cart_item.amount
     @order_detail.price = cart_item.amount * cart_item.item.price
     @order_detail.save
   end
   @cart_items.destroy_all
   redirect_to complete_orders_path
 else
   render :new
 end
end

def complete
  cart_items = current_customer.cart_items
  cart_items.destroy_all
end

def index
  @orders = current_customer.orders
  @cart_items= CartItem.all  
  @orders = Order.page(params[:page]).per(5).reverse_order
end

def show

 
end


private

def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
end


    
end