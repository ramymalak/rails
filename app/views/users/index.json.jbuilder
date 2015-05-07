json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password, :age, :gender, :country_id, :city_id, :isAdmin, :isConf
  json.url user_url(user, format: :json)
end
