class CreatePlatforms < ActiveRecord::Migration
  def up
    create_table :platforms do |t|
      t.string :title
      t.text :description
      t.string :wikipedia_url

      t.timestamps
    end
    Platform.create_translation_table! :title => :string, :description => :text, :wikipedia_url => :string
  end
  def down
    drop_table :platforms
    Platform.drop_translation_table!
  end
end
