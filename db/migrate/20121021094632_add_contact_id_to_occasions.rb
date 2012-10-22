class AddContactIdToOccasions < ActiveRecord::Migration
  def change
    add_column :occasions, :contact_id, :integer
  end
end
