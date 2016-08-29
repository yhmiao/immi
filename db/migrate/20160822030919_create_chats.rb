class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
    	t.integer "user_id"
    	t.string "name"

      t.timestamps
    end

    add_index :chats, :user_id
  end
end