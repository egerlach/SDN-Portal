class CreateNewspostTagJoinTable < ActiveRecord::Migration
  def change
    create_table :newsposts_tags, :id => false do |t|
      t.integer :newspost_id
      t.integer :tag_id
    end
  end
end