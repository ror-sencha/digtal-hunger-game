class CreateSocialMediaPoints < ActiveRecord::Migration
  def change
    create_table :social_media_points do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.integer :points, :default => 0
      t.string :media_type

      t.timestamps
    end
  end
end
