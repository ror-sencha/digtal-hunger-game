class AddColumnPlayerChallengeIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :player_challenge_id, :integer
  end
end
