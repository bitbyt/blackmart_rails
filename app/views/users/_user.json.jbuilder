json.extract! user, :id, :name, :email, :address, :password, :cc_number, :photo_url, :cover_url, :created_at, :updated_at
json.url user_url(user, format: :json)