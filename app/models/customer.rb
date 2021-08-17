class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postcode, presence: true, format: { with: /\A\d{7}\z/ } #郵便番号ハイフンなし7桁
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ } #電話番号ハイフンなし10・11桁

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def active_for_authentication?
    super && (self.is_deleted == false)
  end


end
