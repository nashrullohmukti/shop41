json.extract! product, :id, :name, :price, :description, :picture, :slug, :created_at, :updated_at
json.url product_url(product, format: :json)
