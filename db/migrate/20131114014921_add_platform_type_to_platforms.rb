class AddPlatformTypeToPlatforms < ActiveRecord::Migration
  def change
    add_reference :platforms, :platform_type, index: true
  end
end
