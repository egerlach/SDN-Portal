class AddPostNumberToForumposts < ActiveRecord::Migration
  def change
    add_column :forumposts, :post_number, :integer

  end
end
