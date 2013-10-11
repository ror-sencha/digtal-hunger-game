class AddColumnDescriptionToPlayerChallenges < ActiveRecord::Migration
  def change
    add_column :player_challenges, :description, :text
  end
end
