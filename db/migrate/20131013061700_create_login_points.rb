class CreateLoginPoints < ActiveRecord::Migration
  def change
    create_table :login_points do |t|
      t.integer :user_id
      t.integer :point, :default => 0

      t.timestamps
    end
  end
end
