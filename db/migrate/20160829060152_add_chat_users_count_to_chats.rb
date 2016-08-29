class AddChatUsersCountToChats < ActiveRecord::Migration[5.0]
  def change
  	add_column :chats, :chat_users_count, :integer, default: 0
  end
end