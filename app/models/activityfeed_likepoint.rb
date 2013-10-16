class ActivityfeedLikepoint < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity_feed
end
