json.array!(@entries) do |entry|
  json.extract! entry, :user_id, :content, :source_url, :rt_count, :fav_count, :updated_at
  json.url entry_url(entry, format: :json)
end
