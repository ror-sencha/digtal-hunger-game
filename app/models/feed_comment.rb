class FeedComment < ActiveRecord::Base
	belongs_to :activity_feed
	belongs_to :user
end
