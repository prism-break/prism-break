class AddAttachmentLogoToOperatingSystems < ActiveRecord::Migration
  def self.up
    change_table :operating_systems do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :operating_systems, :logo
  end
end
