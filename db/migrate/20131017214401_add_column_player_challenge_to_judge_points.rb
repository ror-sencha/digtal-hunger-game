class AddColumnPlayerChallengeToJudgePoints < ActiveRecord::Migration
  def change
    add_column :judge_points, :player_challenge_id, :integer
  end
end
