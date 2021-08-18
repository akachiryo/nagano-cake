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
      @customer_kana = Customer.find_by_sql(['select *,last_name_kana || first_name_kana as full_name from customers where full_name LIKE ?', content])
      if @customer_kana.count == 0
        Customer.find_by_sql(['select *,last_name || first_name as full_name from customers where full_name LIKE ?', content])
      else
        Customer.find_by_sql(['select *,last_name_kana || first_name_kana as full_name from customers where full_name LIKE ?', content])
      end
    else
      @customer_kana = Customer.where("first_name_kana || last_name_kana LIKE ?","%" + content + "%")
      if @customer_kana.count == 0
        Customer.where("first_name || last_name LIKE ?","%" + content + "%")
      else
        @customer = Customer.where("first_name_kana || last_name_kana LIKE ?","%" + content + "%")
      end
    end
  end
end