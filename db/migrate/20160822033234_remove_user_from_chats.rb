class RemoveUserFromChats < ActiveRecord::Migration[5.0]
  def change
  	remove_column :chats, :user_id
  end
end