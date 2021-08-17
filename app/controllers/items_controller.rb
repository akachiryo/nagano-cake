class ItemsController < ApplicationController

  def top
    @items=Item.all
  end

  def about
  end

  def index
   @items = Item.page(params[:page]).reverse_order
  end
  
  def show
  @item=Item.find(params[:id])
 
  end
  
 
  

end
