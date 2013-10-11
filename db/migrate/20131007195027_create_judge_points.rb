class CreateJudgePoints < ActiveRecord::Migration
  def change
    create_table :judge_points do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.integer :points

      t.timestamps
    end
  end
end
