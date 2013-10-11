class CreateMiniChallengeAnswers < ActiveRecord::Migration
  def change
    create_table :mini_challenge_answers do |t|
      t.integer :user_id
      t.integer :mini_challenge_id
      t.string :answer

      t.timestamps
    end
  end
end
