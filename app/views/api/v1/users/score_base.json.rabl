object @user
attributes :status, :avatar_url,  :points
node :user_id do |c|
	c.id
end
node :username do |c|
	c.fullname
end