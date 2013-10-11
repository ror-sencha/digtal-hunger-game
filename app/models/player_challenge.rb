class PlayerChallenge < ActiveRecord::Base
	belongs_to :challenge
	has_many :comments
  belongs_to :user

	accepts_nested_attributes_for :comments	#	,:allow_destroy => true

	has_attached_file :avatar,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
    :path => "/player-challenge/avatar/:id/:style/:filename"

  def avatar_url
  	self.avatar.url if self.avatar.present?
  end
end
