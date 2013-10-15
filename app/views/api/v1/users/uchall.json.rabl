object @player_challenge
attributes :created_at
node :title do |r|
  r.challenge.title
end
node :description do |r|
	r.challenge.description
end
