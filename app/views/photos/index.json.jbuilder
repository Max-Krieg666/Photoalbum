json.array!(@photos) do |photo|
  json.extract! photo, :id, :album_id, :title, :creation_date, :description, :num_of_assessments, :sum_of_assessments, :average_rating
  json.url photo_url(photo, format: :json)
end
