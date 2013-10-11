class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string 	:title
      t.date 	:start_date
      t.date 	:end_date
      t.text 	:description
      t.integer :user_id
      t.timestamps
    end
  end
end
