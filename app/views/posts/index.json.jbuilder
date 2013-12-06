json.array!(@posts) do |post|
  json.extract! post, :id, :title, :location_id, :salary, :check
  json.url post_url(post, format: :json)
end
