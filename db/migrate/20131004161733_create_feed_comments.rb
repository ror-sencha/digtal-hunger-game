class CreateFeedComments < ActiveRecord::Migration
  def change
    create_table :feed_comments do |t|
      t.text :message
      t.integer :activity_feed_id
      t.integer :user_id
      t.timestamps
    end
  end
end
