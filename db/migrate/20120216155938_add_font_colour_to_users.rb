class AddFontColourToUsers < ActiveRecord::Migration
  def change
    add_column :users, :font_colour, :string

    add_column :users, :post_colour, :string

  end
end
