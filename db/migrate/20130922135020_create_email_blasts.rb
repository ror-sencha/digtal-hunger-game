class CreateEmailBlasts < ActiveRecord::Migration
  def change
    create_table :email_blasts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
