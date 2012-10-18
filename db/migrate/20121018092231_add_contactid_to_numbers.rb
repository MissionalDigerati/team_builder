class AddContactidToNumbers < ActiveRecord::Migration
  def change
    add_column :numbers, :contact_id, :integer
  end
end
