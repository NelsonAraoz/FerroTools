json.array!(@locations) do |location|
  json.extract! location, :id, :number, :address, :longitude, :latitude, :gmaps
  json.url location_url(location, format: :json)
end
