class CreateVideoPages < ActiveRecord::Migration
  def change
    create_table :video_pages do |t|
      t.string :video_path

      t.timestamps
    end
  end
end
