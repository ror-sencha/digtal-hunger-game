class AddColumnIsPublishedToMiniChallenge < ActiveRecord::Migration
  def change
    add_column :mini_challenges, :is_published, :boolean, :default => false
  end
end
