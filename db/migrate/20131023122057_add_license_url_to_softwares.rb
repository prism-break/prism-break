class AddLicenseUrlToSoftwares < ActiveRecord::Migration
  def up
    add_column :softwares, :license_url, :string
    Software.add_translation_fields! :license_url => :string
  end
  def down
    remove_column :softwares, :license_url, :string
    remove_column :software_translations, :license_url
  end
end
