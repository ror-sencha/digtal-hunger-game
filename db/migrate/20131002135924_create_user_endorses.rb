class CreateUserEndorses < ActiveRecord::Migration
  def change
    create_table :user_endorses do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :endorse_id

      t.timestamps
    end
  end
end
