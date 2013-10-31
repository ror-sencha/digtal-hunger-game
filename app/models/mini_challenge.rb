class MiniChallenge < ActiveRecord::Base

	has_many :challenge_options, :dependent => :destroy
	has_many :minichallenge_points, :dependent => :destroy
	belongs_to :user

	accepts_nested_attributes_for :challenge_options,	 :allow_destroy => true
	
	validates :title, :question, presence: true

	def is_published?
		self.is_published == true
	end
end
