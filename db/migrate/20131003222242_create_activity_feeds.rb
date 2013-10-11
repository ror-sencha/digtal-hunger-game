class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.text :message
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.date :avatar_updated_at
      t.boolean :is_like, :default => false
      t.integer :liked_by
      t.integer :user_id
      t.timestamps
    end
  end
end
