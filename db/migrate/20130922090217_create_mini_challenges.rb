class CreateMiniChallenges < ActiveRecord::Migration
  def change
    create_table :mini_challenges do |t|
      t.string :title
      t.string :question
      t.integer :user_id

      t.timestamps
    end
  end
end
