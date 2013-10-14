object @recent_activity
attributes :id, :message, :user_id, :challenge_id, :rc_type, :comment_id, :created_at
node :avatar_url do |r|
  r.user.avatar_url
end
node :user_first_name do |r|
  r.user.name
end
node :user_last_name do |r|
  r.user.last_name
end
node :endorsement_name do |r|
	User.find(r.comment_id).fullname if r.comment_id.present?
end
node :endorsement_image do |r|
	if r.comment_id.present?
	u = User.find(r.comment_id) 
	if u.avatar.present?
		u.avatar_url
	else
		"#{DOMAIN_CONFIG}/assets/male.png"
	end 
	end
end
