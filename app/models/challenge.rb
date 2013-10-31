class Challenge < ActiveRecord::Base
	belongs_to :user
	has_one :document_challenge, :dependent => :destroy
	has_one :video_challenge, :dependent => :destroy
  has_many :player_challenges, :dependent => :destroy
  has_many :recent_activities, :dependent => :destroy
  has_many :challenge_likes, :dependent => :destroy

  validates :title, :start_date, :end_date, :description, presence: true


  accepts_nested_attributes_for :document_challenge	#	,:allow_destroy => true
  accepts_nested_attributes_for :video_challenge#,		:allow_destroy => true
  accepts_nested_attributes_for :challenge_likes
  accepts_nested_attributes_for :recent_activities

  ## Class Method ##
  ## Instance Method ##

  def is_video_challenge?
  	self.video_challenge.present? 
  end

  def is_document_or_image_challenge?
  	self.document_challenge.present?
  end
  
  def pchallenge(tkn, challenge)
    puts("==#{tkn.inspect}========#{challenge.inspect}===========")
    user = User.find(tkn.id)
    cha1 = Challenge.find(challenge)
    if cha1.player_challenges.find_by_user_id(user.id).present?
      "true"
    else
      "false"
    end
  end
end
