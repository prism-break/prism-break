class AddNotesToSoftwares < ActiveRecord::Migration
  def up
    add_column :softwares, :notes, :text
    Software.add_translation_fields! :notes => :text
  end
  def down
    remove_column :softwares, :notes, :text
    remove_column :software_translations, :notes
  end
end
