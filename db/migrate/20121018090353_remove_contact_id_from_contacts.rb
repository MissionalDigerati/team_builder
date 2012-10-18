class RemoveContactIdFromContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :contact_id
  end

  def down
    add_column :contacts, :contact_id, :string
  end
end
