class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :signature
      t.integer :projects
      t.integer :events
      t.integer :comments
      t.boolean :admin
      t.integer :newsposts
      t.integer :topics
      t.integer :forumposts
      t.text :bio
      t.string :userid
	  t.date :birthday
	  t.boolean :show_year
	  t.boolean :show_email
	  t.integer :achievements

      t.timestamps
    end
  end
end
