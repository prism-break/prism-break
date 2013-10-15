class CreateOperatingSystems < ActiveRecord::Migration
  def up
    create_table :operating_systems do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
    OperatingSystem.create_translation_table! :title => :string, :description => :text, :url => :string
  end
  def down
    drop_table :operating_systems
    OperatingSystem.drop_translation_table!
  end
end
