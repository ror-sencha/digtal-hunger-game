class AddColumnIsPublishedToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :is_published, :boolean, :default => false
  end
end
