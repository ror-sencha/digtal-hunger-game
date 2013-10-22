object @user
attributes :status, :avatar_url
node :user_id do |c|
	c.id
end
node :username do |c|
	c.fullname
end
node :challenges_point do |c|
	if c.challenges_points.present? && c.challenges_points.map(&:point).present?
		c.challenges_points.map(&:point).sum 
	else
		0
	end
end
node :social_media_point do |c|
	c.social_media_points.map(&:points).sum if c.social_media_points.present?
end
node :support_point do |c|
	c.support_points.map(&:point).sum
end
node :minichallenge_point do |c|
	c.minichallenge_points.map(&:points).sum
end
node :login_point do |c|
 c.login_points.map(&:point).sum
end
node :like_and_dislike_point do |c|
 c.activityfeed_likepoints.map(&:point).sum
end
node :feed_comment_point do |c|
	c.feed_comments.map(&:point).sum
end
node :points do |c|
	c.points if c.points.present?
end
