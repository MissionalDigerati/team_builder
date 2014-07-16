class ChangeDefaultValueForPresentedVisionOnContacts < ActiveRecord::Migration
  def change
    change_column_default :contacts, :presented_vision, false
  end
end
