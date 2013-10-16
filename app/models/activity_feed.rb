class ActivityFeed < ActiveRecord::Base
	belongs_to :user
	has_many :feed_comments
  has_many :activityfeed_likepoints  
	#has_attached_file :avatar,
  #  :styles => { :thumb => "50x50>", :medium => "200x200>", :large => "640x640>"},
  #  :storage => :s3,
  #  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  #  :path => "/activity_feed/:id/:style/:filename"

    has_attached_file :avatar,
                      :styles => { :thumb => "50x50>", :medium => "200x200>", :large => "640x640>"},
                      :path => "public/system/activity_feed/:attachment/:id_partition/:style/:filename",
                      :url => "/system/activity_feed/:attachment/:id_partition/:style/:filename"


    def avatar_url
    	if self.avatar_file_name.present?
        "#{DOMAIN_CONFIG}/#{self.avatar.url}"
      else
        "#{DOMAIN_CONFIG}/assets/male.png"
      end
    end
end
