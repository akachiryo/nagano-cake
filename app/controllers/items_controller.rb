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
    @cart_item = CartItem.new
 
  end
  
  def genre_search
    #検索結果画面でもタグ一覧表示
    @genres=Genre.all
　　　　　　　#検索されたタグを受け取る
    @genre=Genre.find(params[:genre_id])
　　　　　　　　#検索されたタグに紐づく投稿を表示
    @items=@genre.items.page(params[:page]).per(10)
  end
  
 
  

end
