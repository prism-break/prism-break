class CreateProtocolSoftwares < ActiveRecord::Migration
  def change
    create_table :protocol_softwares do |t|
      t.references :protocol, index: true
      t.references :software, index: true

      t.timestamps
    end
  end
end
