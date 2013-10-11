class AddColumnLikesToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :likes, :integer, :default => 0
  end
end
