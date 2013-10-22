object @user
attributes :name, :email, :sex, :title, :company, :bio, :status, :avatar_url, :last_name, :country, :company_title, :points, :support, :mini_points
node :user_id do |cd|
	cd.id
end
node :skills do |c|
  c.user_skills.map(&:skill).map{|p| {"id" => p.id, "name" => p.name}}
end
node :challenges_point do |c|
	c.challenges_points.map(&:point).sum if c.challenges_points.present?
end
node :social_media_point do |c|
	c.social_media_points.map(&:points).sum if c.social_media_points.present? 
end
node :support_point do |c|
	c.support_points.map(&:point).sum if c.support_points.present?
end
node :minichallenge_point do |c|
	c.minichallenge_points.map(&:points).sum if c.minichallenge_points.present?
end
node :login_point do |c|
 c.login_points.map(&:point).sum if c.login_points.present?
end
node :skills_endorse do |c|
	UserEndorse.where("endorse_id = ? && user_id = ?", c.id, @current_user.id).map(&:skill_id) if c.present? && @current_user.present?
end
node :md_name do |c|
	User.find(c.md_id).fullname if c.md_id.present?
end