class AddPresentedVisionToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :presented_vision, :boolean, default: 0
  end
end
