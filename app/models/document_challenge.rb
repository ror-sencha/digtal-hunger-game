class DocumentChallenge < ActiveRecord::Base
	belongs_to :challenge

	  has_attached_file :avatar,
	  									:path => "public/system/document_challenge/:attachment/:id_partition/:style/:filename",
                    	:url => "/system/document_challenge/:attachment/:id_partition/:style/:filename"

		#has_attached_file :avatar,
    #	:storage => :s3,
    #	:s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
   # 	:path => "/document_challenge/:id/:style/:filename"

  def is_image_document?
  	["image/png", "image/jpg", "image/jpeg"].include?(self.avatar_content_type)
  end

  def document_challenge_avatar
    #{}"#{DOMAIN_CONFIG}#{
    self.avatar.url
  end

end
