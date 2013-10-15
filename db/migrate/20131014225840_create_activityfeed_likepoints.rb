class CreateActivityfeedLikepoints < ActiveRecord::Migration
  def change
    create_table :activityfeed_likepoints do |t|
      t.integer :activity_feed_id
      t.integer :user_id
      t.integer :point, :default => 0
      t.boolean :is_like, :default => 0
      t.timestamps
    end
  end
end
