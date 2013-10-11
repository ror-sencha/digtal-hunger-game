namespace :hunger_game do
  desc "Create Admin User"
  task :add_admin => :environment do
    user = User.new
    user.name = "admin"
    user.email = "admin@yopmail.com"
    user.sex = "male"
    user.title = "admin"
    user.company = "hunger_game"
    user.bio = "bio"
    user.password = "admin@123"
    user.status = "admin"
    user.confirmed_at = Time.now
    user.confirmation_token = nil
    user.save
  end
end