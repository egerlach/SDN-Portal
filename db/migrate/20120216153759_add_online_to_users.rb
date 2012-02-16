class AddOnlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean

    add_column :users, :show_online, :boolean

    add_column :users, :technologies, :integer

  end
end
