class AddColumnSupportToUser < ActiveRecord::Migration
  def change
    add_column :users, :support, :integer
  end
end
