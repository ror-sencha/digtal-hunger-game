collection @users, :root => "users", :object_root => false
attributes :name, :last_name, :avatar_url, :title, :company, :company_title, :bio, :email
node :user_id do |c|
	c.id
end
