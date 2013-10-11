class Comment < ActiveRecord::Base
	belongs_to :player_challenge
	has_many :recent_activities
		  
	has_attached_file :avatar,
	 									:path => "public/system/comment/:attachment/:id_partition/:style/:filename",
                  	:url => "/system/comment/:attachment/:id_partition/:style/:filename"

	#has_attached_file :avatar,
  #  :storage => :s3,
  #  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  #  :path => "/comments/avatar/:id/:style/:filename"

end
