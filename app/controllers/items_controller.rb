class ItemsController < ApplicationController
  
  def top
    @items=Item.all
  end
  
  def about
  end
  
  def index
  end
  
end
