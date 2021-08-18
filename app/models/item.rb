class Item < ApplicationRecord
 attachment :image
 has_many :cart_item, dependent: :destroy
 belongs_to :genre, class_name: 'Genre', foreign_key: 'genre_id'
 has_many :order_detail, dependent: :destroy
 
  def add_tax_price
   (self.price / 1.08).round
  end
 
end
