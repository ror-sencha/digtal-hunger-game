object @player_challenge
attributes :created_at
node :title do |r|
  r.challenge.title if r.challenge.present? && r.challenge.title.present?
end
node :description do |r|
	r.challenge.description if r.challenge.present? && r.challenge.description.present?
end
