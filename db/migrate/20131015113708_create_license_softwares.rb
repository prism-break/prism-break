class CreateLicenseSoftwares < ActiveRecord::Migration
  def change
    create_table :license_softwares do |t|
      t.references :license, index: true
      t.references :software, index: true

      t.timestamps
    end
  end
end
