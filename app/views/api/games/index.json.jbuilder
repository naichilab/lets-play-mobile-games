json.games @games do |game|
  json.id game.id
  json.title game.title
  json.specific_conditions game.specific_conditions
  json.category_id game.category_id
  json.guideline game.guideline
  json.icon do
    json.thumb do
      json.url game.icon.thumb.url
    end
  end

  @platforms.each do |p|
    json.set! "has_#{p.code}", game.has_platform(p.code)
  end

end