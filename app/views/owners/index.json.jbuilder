json.array!(@owners) do |owner|
  json.extract! owner, :id, :login, :password, :residence, :sex, :birthday, :mail, :page_link
  json.url owner_url(owner, format: :json)
end
