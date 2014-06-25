class AddProvinceToContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :province, :string
  end

  def down
    remove_column :contacts, :province
  end
end
