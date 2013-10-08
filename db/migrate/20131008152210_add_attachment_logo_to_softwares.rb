class AddAttachmentLogoToSoftwares < ActiveRecord::Migration
  def self.up
    change_table :softwares do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :softwares, :logo
  end
end
