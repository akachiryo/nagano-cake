class CartItem < ApplicationRecord
  
    belongs_to :customer
    belongs_to :item
    

    validates :amount, numericality:{ only_integer: true }, presence: true

    def sum_of_price
      item.price * amount
    end
end
