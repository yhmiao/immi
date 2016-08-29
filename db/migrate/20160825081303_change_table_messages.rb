class ChangeTableMessages < ActiveRecord::Migration[5.0]
  def change
  	remove_column :messages, :chat_user_id
  	add_reference :messages, :user, index: true
  	add_reference :messages, :chat, index: true
  end
end