class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.integer :user_id
      t.string  :auth_token
      t.date    :last_used_at
      t.timestamps
    end
  end
end
