object @recent_activity
attributes :message, :is_like, :user_id, :created_at, :liked_by
node :profile_image do |c|
	c.user.avatar.url if c.user.avatar.present?
end
node :avatar_image do |c|
	c.avatar.url if c.avatar.present?
end
node :user_name do |c|
	c.user.fullname
end
node :activity_id do |c|
	c.id
end
child :feed_comments, :object_root => false do
  extends("api/v1/activity_feeds/base1")
end

