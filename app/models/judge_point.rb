class JudgePoint < ActiveRecord::Base
	belongs_to :user
	belongs_to :player_challenge
end
