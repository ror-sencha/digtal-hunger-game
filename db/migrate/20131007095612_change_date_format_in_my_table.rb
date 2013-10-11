class ChangeDateFormatInMyTable < ActiveRecord::Migration
	def self.up
   change_column :activity_feeds, :avatar_updated_at, :datetime
  end

  def self.down
   change_column :activity_feeds, :avatar_updated_at, :date
  end
end
