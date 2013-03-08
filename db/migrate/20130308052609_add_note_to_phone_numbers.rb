class AddNoteToPhoneNumbers < ActiveRecord::Migration
  def up
  	add_column :numbers, :note, :string
  end

  def down
  	remove_column :numbers, :note
  end
end
