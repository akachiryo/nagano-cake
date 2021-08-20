class Admins::OrdersController < ApplicationController
  
  before_action :authenticate_admin!

def index
 @orders = Order.page(params[:page]).reverse_order
end

def show
  @order=Order.find(params[:id])
   @orders = current_customer.orders
end


end    