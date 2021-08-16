class Address < ApplicationRecord
  validates :postcode, presence: true, format: { with: /\A\d{7}\z/ } #郵便番号ハイフンなし7桁
  validates :address, presence: true
  validates :name, presence: true

  belongs_to :customer
end
