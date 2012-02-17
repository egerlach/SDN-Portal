class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :signature
      t.boolean :admin
      t.text :bio
      t.string :userid
	  t.date :birthday
	  t.boolean :show_year
	  t.boolean :show_email

      t.timestamps
    end
  end
end
