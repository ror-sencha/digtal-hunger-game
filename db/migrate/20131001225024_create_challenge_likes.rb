class CreateChallengeLikes < ActiveRecord::Migration
  def change
    create_table :challenge_likes do |t|
      t.integer :user_id
      t.integer :challenge_id

      t.timestamps
    end
  end
end
