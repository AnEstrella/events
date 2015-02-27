class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.references :event, index: true

      t.timestamps
    end
  end
end
