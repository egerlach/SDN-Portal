class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :user_id
      t.integer :forumposts
      t.integer :tags
	  t.integer :category_id
	  t.integer :views

      t.timestamps
    end
  end
end
