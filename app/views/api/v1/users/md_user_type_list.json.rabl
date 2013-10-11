collection @md_users, :root => "md_users", :object_root => false
attributes :mdid, :fullname
node :video_link do |c|
  VideoPage.first.video_path if VideoPage.first.present?
end

