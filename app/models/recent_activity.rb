class RecentActivity < ActiveRecord::Base
	belongs_to :user
	belongs_to :challenge
	belongs_to :comment
end
