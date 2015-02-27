class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :location
      t.string :state
      t.integer :user_id

      t.timestamps
    end
  end
end
