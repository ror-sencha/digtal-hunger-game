class MiniChallenge < ActiveRecord::Base

	has_many :challenge_options
	has_many :minichallenge_points
	belongs_to :user

	accepts_nested_attributes_for :challenge_options,	 :allow_destroy => true
	
	validates :title, :question, presence: true

end
