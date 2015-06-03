json.array!(@usergroups_accesses) do |usergroups_access|
  json.extract! usergroups_access, :id, :photo_id, :usergroup_id, :access
  json.url usergroups_access_url(usergroups_access, format: :json)
end
