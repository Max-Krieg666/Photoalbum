json.array!(@user_usergroups) do |user_usergroup|
  json.extract! user_usergroup, :id, :usergroup_id, :user_id, :begin_date, :description
  json.url user_usergroup_url(user_usergroup, format: :json)
end
