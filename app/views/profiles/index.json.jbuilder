json.array!(@profiles) do |profile|
  json.extract! profile, :id, :Name, :Birthiday, :Occupation, :user_id
  json.url profile_url(profile, format: :json)
end
