class CreateChallengeOptions < ActiveRecord::Migration
  def change
    create_table :challenge_options do |t|
      t.string :option
      t.integer :mini_challenge_id
      t.boolean :answer, :default => false
      t.timestamps
    end
  end
end
