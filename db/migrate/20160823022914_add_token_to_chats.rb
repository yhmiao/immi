class AddTokenToChats < ActiveRecord::Migration[5.0]
  def change
  	add_column :chats, :token, :string
  	add_index :chats, :token
  end
end