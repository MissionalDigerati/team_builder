class ChangeStringToDate < ActiveRecord::Migration
  def up
    remove_column :donations, :date
    add_column :donations, :donation_date, :date
  end

  def down
    remove_column :donations, :donation_date
    add_column :donations, :date, :string
  end
end
