class AddColumnNameToUser < ActiveRecord::Migration
  def change
    add_column 		:users, :name, 		:string
    add_column 		:users, :sex, 		:string
    add_column 		:users, :title, 	:string
    add_column 		:users, :company, 	:string
    add_column 		:users, :bio, 		:string
    add_column 		:users, :status, 	:string, :default => "spectator"
    add_attachment 	:users, :avatar
  end
end
