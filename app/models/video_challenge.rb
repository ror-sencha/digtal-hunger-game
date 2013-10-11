class VideoChallenge < ActiveRecord::Base
	belongs_to :challenge

	#has_attached_file :avatar,
  #									:path => "public/system/video_challenge/:attachment/:id_partition/:style/:filename",
   #                 :url => "/system/video_challenge/:attachment/:id_partition/:style/:filename"

  has_attached_file :avatar,
   	:storage => :s3,
   	:s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
    :path => "/video_challenge/:id/:style/:filename"


  def video_challenge_avatar
    #{}"#{DOMAIN_CONFIG}#
    self.avatar.url
  end

end
