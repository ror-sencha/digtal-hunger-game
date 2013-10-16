class AddColumnPointToFeedComment < ActiveRecord::Migration
  def change
    add_column :feed_comments, :point, :integer, :default => 0
  end
end
