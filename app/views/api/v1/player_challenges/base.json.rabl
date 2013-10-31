object @playes_challenge
attributes :challenge_id, :user_id, :description, :post_url, :make_public, :judge_can_view, :date_submitted, :avatar_content_type
node :name do |cd|
	cd.user.name if cd.user.present? && cd.user.name.present?
end
node :last_name do |cd|
	cd.user.last_name if cd.user.present? && cd.user.email.present?
end
node :email do |cd|
	cd.user.email if cd.user.present?
end
node :avatar_url do |cd|
	cd.user.avatar_url if cd.user.present?
end
node :player_challenge_id do |c|
	c.id
end