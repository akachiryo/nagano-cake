class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  has_many :addresses, dependent: :destroy

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
         
  has_many :cart_items, dependent: :destroy
  
  def self.search_for(content, method)
    if method == "perfect"
      @customer = Customer.where("first_name_kana LIKE ?", "%" + content)
      if @customer == nil
        Customer == nil
      else
        @customer = @customer.where("last_name_kana LIKE ?", content + "%")
      end
      
    else
      @customer = Customer.where("last_name_kana LIKE ?", "%" + content + "%")
      if @customer.count == 0
         @customer = Customer.where("first_name_kana LIKE ?", "%" + content + "%")
          if @customer.count == 0
            @customer = Customer.where("last_name LIKE ?", "%" + content + "%")
          else
            Customer.where("last_name LIKE ?", "%" + content + "%")
          end
        else
          Customer.where("first_name_kana LIKE ?", "%" + content + "%")
        end
      else
        Customer.where("last_name_kana LIKE ?", "%" + content + "%")
      end
    end
  end
end
