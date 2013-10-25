class AddWikipediaUrlToSoftwares < ActiveRecord::Migration
  def up
    add_column :softwares, :wikipedia_url, :string
    Software.add_translation_fields! :wikipedia_url => :string
  end
  def down
    remove_column :softwares, :wikipedia_url, :string
    remove_column :software_translations, :wikipedia_url
  end
end
