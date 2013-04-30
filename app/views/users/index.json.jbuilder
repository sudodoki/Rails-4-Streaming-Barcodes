json.array!(@users) do |user|
  json.extract! user, :login, :password
  json.url user_url(user, format: :json)
end