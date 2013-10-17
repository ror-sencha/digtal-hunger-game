class AddColumnActivityfeedIdToPlayerChallenge < ActiveRecord::Migration
  def change
    add_column :player_challenges, :activityfeed_id, :integer
  end
end
