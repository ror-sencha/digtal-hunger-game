class CreateRecentActivities < ActiveRecord::Migration
  def change
    create_table :recent_activities do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.string :type
      t.text :message
      t.integer :comment_id
      t.timestamps
    end
  end
end
