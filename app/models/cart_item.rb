class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item
    
    validates :customer_id, :item_id, :amount, presence: true
    validates :amount, numericality:{ only_integer: true }

    def sum_of_price
    item.price * amount
    end
    
end
