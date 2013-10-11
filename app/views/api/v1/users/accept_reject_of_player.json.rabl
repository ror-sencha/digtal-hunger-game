collection @accept_reject_player, :root => "accept_reject_player", :object_root => false
attributes :name, :email, :sex, :title, :company, :bio, :status, :avatar_url, :last_name, :country, :company_title
node :user_id do |c|
	c.id
end
node :skills do |c|
  c.user_skills.map(&:skill).map{|p| {"id" => p.id, "name" => p.name}}
end
