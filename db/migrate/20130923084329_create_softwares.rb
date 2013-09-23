class CreateSoftwares < ActiveRecord::Migration
  def up
    create_table :softwares do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :source_url
      t.string :privacy_url
      t.string :tos_url

      t.timestamps
    end
    Software.create_translation_table! :title => :string, :description => :text, :url => :string, :source_url => :string, :privacy_url => :string, :tos_url => :string
  end

  def down
    drop_table :softwares
    Software.drop_translation_table!
end
