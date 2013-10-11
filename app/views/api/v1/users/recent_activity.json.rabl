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
