class AddPlatformToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :platform, index: true
  end
end
