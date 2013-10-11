class AddColumnAvatarToPlayerChallenge < ActiveRecord::Migration
  def change
  	add_attachment :player_challenges, :avatar
  end
end
