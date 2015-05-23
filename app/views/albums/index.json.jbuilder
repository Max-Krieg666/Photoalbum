json.array!(@albums) do |album|
  json.extract! album, :id, :owner_id, :name, :creation_date
  json.url album_url(album, format: :json)
end
