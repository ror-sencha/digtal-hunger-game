class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.string :description
      t.integer :challenge_id
      t.integer :user_id
      t.string :challenge_type

      t.timestamps
    end
  end
end
