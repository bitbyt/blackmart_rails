class Product < ApplicationRecord
  belongs_to :product_photo
  belongs_to :brand
  belongs_to :category
end
