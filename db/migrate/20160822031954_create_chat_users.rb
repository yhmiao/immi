class CreateChatUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_users do |t|
    	t.integer "chat_id"
    	t.integer "user_id"

      t.timestamps
    end

    add_index :chat_users, :chat_id
    add_index :chat_users, :user_id
  end
end