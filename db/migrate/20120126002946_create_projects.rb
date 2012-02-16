class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :tags
      t.integer :users
      t.text :content
      t.string :blurb
	    t.integer :creator
      t.integer :category_id

      t.timestamps
    end
  end
end
