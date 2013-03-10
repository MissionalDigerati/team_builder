class AddAvatarToContacts < ActiveRecord::Migration

  def self.up
    add_attachment :contacts, :avatar
  end

  def self.down
    remove_attachment :contacts, :avatar
  end

end
