json.array!(@posts) do |post|
  json.extract! post, :id, :title, :company, :salary, :check
  json.url post_url(post, format: :json)
end
