class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :name
	  t.boolean :video
      t.text :content
	  t.string :description

      t.timestamps
    end
  end
end
