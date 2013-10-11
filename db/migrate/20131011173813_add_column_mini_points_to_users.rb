class AddColumnMiniPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mini_points, :integer, :default => 0
  end
end
