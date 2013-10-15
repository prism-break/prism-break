class CreateLicenses < ActiveRecord::Migration
  def up
    create_table :licenses do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
    License.create_translation_table! :title => :string, :description => :text, :url => :string
  end
  def down
    drop_table :licenses
    License.drop_translation_table!
  end
end
