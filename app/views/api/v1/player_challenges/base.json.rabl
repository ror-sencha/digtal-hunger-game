object @playes_challenge
attributes :challenge_id, :user_id, :description, :post_url, :make_public, :judge_can_view, :date_submitted, :avatar_content_type
node :name do |cd|
	cd.user.name
end
node :last_name do |cd|
	cd.user.last_name
end
node :email do |cd|
	cd.user.email
end
node :avatar_url do |cd|
	cd.user.avatar_url
end
