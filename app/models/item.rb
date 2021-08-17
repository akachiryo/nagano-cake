class Item < ApplicationRecord
 attachment :image
 has_many :cart_item, dependent: :destroy
end
