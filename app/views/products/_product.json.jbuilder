json.extract! product, :id, :name, :price, :price, :description, :product_photo_id, :brand_id, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)