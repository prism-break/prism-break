class AddDescriptionToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :description, :text
    Category.add_translation_fields! :description => :text
  end
  def down
    remove_column :categories, :description, :text
    remove_column :category_translations, :description
  end
end
