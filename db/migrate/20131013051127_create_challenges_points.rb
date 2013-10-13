class CreateChallengesPoints < ActiveRecord::Migration
  def change
    create_table :challenges_points do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.integer :point, :default => 0

      t.timestamps
    end
  end
end
