class UserEndorse < ActiveRecord::Base
	belongs_to :user
	belongs_to :skill
	belongs_to :endorse
end
