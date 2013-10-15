class CreateOperatingSystemSoftwares < ActiveRecord::Migration
  def change
    create_table :operating_system_softwares do |t|
      t.references :operating_system, index: true
      t.references :software, index: true

      t.timestamps
    end
  end
end
