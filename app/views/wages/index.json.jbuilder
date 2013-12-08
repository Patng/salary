json.array!(@wages) do |wage|
  json.extract! wage, :id, :title, :company, :location_id, :total, :avg, :high, :low
  json.url wage_url(wage, format: :json)
end
