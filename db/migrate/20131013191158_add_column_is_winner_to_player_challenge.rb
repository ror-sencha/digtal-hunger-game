class AddColumnIsWinnerToPlayerChallenge < ActiveRecord::Migration
  def change
    add_column :player_challenges, :is_winner, :boolean, :default => false
  end
end
