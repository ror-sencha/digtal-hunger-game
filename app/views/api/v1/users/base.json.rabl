object @user
attributes :name, :email, :sex, :title, :company, :bio, :status, :avatar_url, :last_name, :country, :company_title, :points, :support, :mini_points
node :user_id do |cd|
	cd.id
end
node :skills do |c|
  c.user_skills.map(&:skill).map{|p| {"id" => p.id, "name" => p.name}}
end
node :challenges_point do |c|
	c.challenges_points.map(&:point).sum
end