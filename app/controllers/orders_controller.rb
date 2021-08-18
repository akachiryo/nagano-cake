class OrdersController < ApplicationController
  
  before_action :authenticate_customer!
  
def new
  @order_new = Order.new(order_params)
  @customer = current_customer
  @addresses = Address.all
end

def create 
  @order = Order.new(order_params)
end

def confirm
  @order=Order.new(order_params)
  @cart_items= current_customer.cart_items.all  
end

def complete
end

if @order.invalid?
      # new.html.erbで必要な変数を宣言する。　ここから
      #customersテーブルの、ログインしている会員のレコードを取り出す。
      @customer = current_customer
      #deliveriesテーブルの、ログインしている会員が登録した配送先のレコードを取り出す。
      deliveries = current_customer.deliveries
      #配列をつくるために、Arrayクラスのインスタンスを生成する。
      @array_deliveries = Array.new
      #eachメソッドでdeliveriesからレコードを一つずつ取り出して、繰り返し処理を行う。
      deliveries.each do |delivery|
        #レコードの値を取り出していく。
        postcode = delivery.postcode
        address = delivery.address
        name = delivery.name
        #変数展開を使って、取り出した値を結合させて文字列にする。
        delivery_info = "〒#{postcode} #{address} #{name}"
        #配列をつくるために、Arrayクラスのインスタンスを生成する。
        array_delivery = Array.new
        #配列array_deliveryに文字列delivery_infoと数値delivery.idを要素として追加する。
        array_delivery.push(delivery_info, delivery.id)
        #配列@array_deliveriesに配列array_deliveryを要素として追加する。
        @array_deliveries.push(array_delivery)
      end
      # 入力した値を再びpublic/orders/new.html.erbのフォームに表示させるための変数を宣言する。　ここから
      @postcode = params[:postcode]
      @address = params[:address]
      @name = params[:name]
      if params[:payment] == "0"
        @payment_method_0 = true
      elsif params[:paymen] == "1"
        @payment_method_1 = true
      end
      if params[:address] == "1"
        @delivery_1 = true
      elsif params[:address] == "2"
        @delivery_2 = true
      elsif params[:address] == "3"
        @delivery_3 = true
      end
      # 入力した値を再びpublic/orders/new.html.erbのフォームに表示させるための変数を宣言する。　ここまで
      # new.html.erbで必要な変数を宣言する。　ここまで
      # renderで遷移先を指定する。

      # ここからくまさん追記 / 07/27 14:05
      flash.now[:notice] = "お届け先を指定してください"
      # ここまでくまさん追記 / 07/27 14:05
      render :new
    end
 



private

def order_params
  params.require(:order).permit(:customer_id, :postcode, :address, :name, :payment, :total_payment,:delivery_fee)
end

end
