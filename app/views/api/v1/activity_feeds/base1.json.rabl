object @feed_comment
attributes :message, :user_id, :created_at
node :profile_image do |c|
	c.user.avatar.url if c.user.present? && c.user.avatar.present?
end
node :user_name do |c|
	c.user.fullname
end

