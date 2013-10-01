class TranslateTags < ActiveRecord::Migration
  def self.up
    ActsAsTaggableOn::Tag.create_translation_table!({
      :name => :string
    }, {
      :migrate_data => true
    })
  end

  def self.down
    ActsAsTaggableOn::Tag.drop_translation_table! :migrate_data => true
  end
end
