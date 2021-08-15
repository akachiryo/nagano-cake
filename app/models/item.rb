class Item < ApplicationRecord
 attachment :image
 belongs_to :genre, class_name: 'Genre', foreign_key: 'genre_id'
 
  def add_tax_price
   (self.price / 1.08).round
  end
 
end
