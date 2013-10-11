class CreateMinichallengePoints < ActiveRecord::Migration
  def change
    create_table :minichallenge_points do |t|
      t.integer :mini_challenge_id
      t.integer :user_id
      t.integer :points

      t.timestamps
    end
  end
end
