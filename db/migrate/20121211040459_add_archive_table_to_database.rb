class AddArchiveTableToDatabase < ActiveRecord::Migration
  def up
    create_table :archives do |t|
      t.string :filename

      t.timestamps
    end
  end

  def down
    drop_table :archives
  end
end
