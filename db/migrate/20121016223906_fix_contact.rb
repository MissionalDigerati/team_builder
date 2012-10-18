class FixContact < ActiveRecord::Migration
  def change
      rename_column :contacts, :prefered_contact, :preferred_contact
  end
end
