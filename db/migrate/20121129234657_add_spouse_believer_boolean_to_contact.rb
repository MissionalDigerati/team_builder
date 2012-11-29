class AddSpouseBelieverBooleanToContact < ActiveRecord::Migration
  def up
    add_column :contacts, :spouse_believer, :boolean
  end

  def down
    remove_column :contacts, :spouse_believer
  end
end
