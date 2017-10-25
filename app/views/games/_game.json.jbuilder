json.extract! game, :id, :title, :permission, :specific_conditions, :android_url, :ios_url, :created_at, :updated_at
json.url game_url(game, format: :json)
