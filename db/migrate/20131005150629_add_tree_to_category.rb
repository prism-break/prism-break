class AddTreeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :parent_id, :integer
    add_column :categories, :sort_order, :integer
  end
end
