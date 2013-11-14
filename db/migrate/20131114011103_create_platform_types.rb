class CreatePlatformTypes < ActiveRecord::Migration
  def up
    create_table :platform_types do |t|
      t.string :title

      t.timestamps
    end
    PlatformType.create_translation_table! :title => :string
  end
  def down
    drop_table :platform_types
    PlatformType.drop_translation_table!
  end
end
