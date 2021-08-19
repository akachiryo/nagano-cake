class OrdersController < ApplicationController
    
def new
  @order = Order.new
  @addresses = current_customer.addresses
end

def confirm
  @order = Order.new(order_params)
  @curt_item = current_customer.curt_items
  @order.customer_id = current_customer.id
  if @order.address == 0
    @order.postal_code = current_customer.postcode
    @order.address = current_customer.address
  elsif @order.address == 1
  elsif @order.address == 2
  end
    
  @order.shipping_cost = 800
  @order.total_payment = shipping_cost + 
  
  
  
  
  @cart_items= CartItem.all  
  @cart_item=CartItem.new
  @order.customer_id=current_customer.id
  @order.shipping_cost ="800"
  @total_payment = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  
end

def create 
 @order = Order.new(order_params)
 @order_detail=OrderDetail.new
 @order_detail.order_id=@order.id

 
 @order.items.each do |item|
     @order_detail.item_id=item.id
     @order_detail.amount=item.cart_items.amount
     @order_detail.price=item.price*item.cart_items.amount
  end   
  
 @cart_items = CartItem.where(customer_id:current_customer.id)
 if @order.save
    @order_detail
 redirect_to complete_orders_path
 else
 render 'new'
 end
end

def complete
  cart_items = current_customer.cart_items
  cart_items.destroy_all
end

def index
  @orders = current_customer.orders
  @cart_items= CartItem.all  
 
end

def show
 @order_details=OrderDetail.all    
 @order=Order.find(params[:id])    
 
end


private

def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
end


    
end