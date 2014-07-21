class AddTeamStatusDatesToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :letter_sent_on, :date
    add_column :contacts, :presented_vision_on, :date
    add_column :contacts, :responded_on, :date
    add_column :contacts, :team_status_updated_on, :date
  end
end
