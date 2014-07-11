class ChangeColumnTypeForNoteOnNotes < ActiveRecord::Migration
  def change
    change_column :notes, :note,  :text
  end
end
