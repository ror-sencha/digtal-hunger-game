class AddColumnMdIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :md_id, :integer
    add_column :users, :accept_as_player, :boolean, :default => false
    add_column :users, :reject_as_player, :boolean, :default => false
    add_column :users, :message_for_rejection, :text
  end
end
