class Genre < ApplicationRecord
  
  has_many :items, dependent: :destroy
  
  def self.search_for(content, method)
    if method == "perfect"
      Genre.where(name: content)
    else
      Genre.where("name LIKE ?", "%" + content + "%")
    end
  end
  
end
