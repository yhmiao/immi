class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.references :user
      t.integer :contactee_id
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end