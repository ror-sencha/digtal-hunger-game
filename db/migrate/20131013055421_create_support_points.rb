class CreateSupportPoints < ActiveRecord::Migration
  def change
    create_table :support_points do |t|
      t.integer :user_id
      t.integer :support_id
      t.integer :point, :default => 0

      t.timestamps
    end
  end
end
