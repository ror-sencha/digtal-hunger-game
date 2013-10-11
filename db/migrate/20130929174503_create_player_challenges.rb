class CreatePlayerChallenges < ActiveRecord::Migration
  def change
    create_table :player_challenges do |t|
      t.integer :challenge_id
      t.integer :user_id
      t.date :date_submitted
      t.string :youtube_link
      t.boolean :make_public, :default => false
      t.boolean :judge_can_view, :default => false
      t.timestamps
    end
  end
end
