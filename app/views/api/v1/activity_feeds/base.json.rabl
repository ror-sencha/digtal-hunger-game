object @recent_activity
attributes :message, :user_id, :created_at, :liked_by
node :profile_image do |c|
	c.user.avatar_url if c.user.avatar.present?
end
node :avatar_image do |c|
	c.avatar_url if c.avatar.present?
end
node :user_name do |c|
	c.user.fullname
end
node :status do |c|
	c.user.status
end
node :activity_id do |c|
	c.id
end
node :is_like do |c|
	if ActivityfeedLikepoint.find_by_user_id_and_activity_feed_id(@user,c.id).present?
		ActivityfeedLikepoint.find_by_user_id_and_activity_feed_id(@user,c.id).is_like
	else
		false
	end
end

child :feed_comments, :object_root => false do
  extends("api/v1/activity_feeds/base1")
end

