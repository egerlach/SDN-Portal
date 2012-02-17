class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :blurb
      t.text :content
      t.integer :user_id
      t.datetime :start_at
	  t.datetime :end_at
      t.string :location
      t.integer :slots
      t.boolean :open

      t.timestamps
    end
  end
end
