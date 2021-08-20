class Admins::OrdersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
   @orders = Order.page(params[:page]).per(10).reverse_order
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_ststus_params)
    redirect_to admins_order_path(@order)
    
  end
  
  private
  
  def order_ststus_params
        params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status).merge(status: params[:order][:status].to_i)
  end



end    