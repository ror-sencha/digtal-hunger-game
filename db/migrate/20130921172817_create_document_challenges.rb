class CreateDocumentChallenges < ActiveRecord::Migration
  def change
    create_table :document_challenges do |t|
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.integer :challenge_id

      t.timestamps
    end
  end
end
