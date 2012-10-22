class RemovingUnNeededTables < ActiveRecord::Migration
  def up
    drop_table :phone_numbers
    drop_table :special_dates
  end

  def down
  end
end
