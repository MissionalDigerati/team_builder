class AddBelieverToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :believer, :boolean
  end
end
