class RemoveTagsFromContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :tags
  end

  def down
    add_column :contacts, :tags, :string
  end
end
