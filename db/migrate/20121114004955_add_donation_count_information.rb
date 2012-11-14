class AddDonationCountInformation < ActiveRecord::Migration
  def up
    add_column :contacts, :donations_count, :integer, :default => 0
  end

  def down
    remove_column :contacts, :donations_count
  end
end
