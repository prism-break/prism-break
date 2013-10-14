class TranslateProtocols < ActiveRecord::Migration
  def self.up
    Protocol.create_translation_table!({
      :title => :string,
      :description => :text,
      :url => :string
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Protocol.drop_translation_table! :migrate_data => true
  end
end
