class MinichallengePoint < ActiveRecord::Base
	belongs_to :user
	belongs_to :mini_challenge
end
