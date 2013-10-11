class AddColumnRcTypeToRecentActivity < ActiveRecord::Migration
  def change
    add_column :recent_activities, :rc_type, :string
  end
end
