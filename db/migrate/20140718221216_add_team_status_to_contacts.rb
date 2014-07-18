class AddTeamStatusToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :team_status, :string, default: :initial 
    add_index :contacts, :team_status

    # Update all contacts
    #
    Contact.all.each do |c|
      c.update_attributes({ team_status: :initial })
    end
  end

  def self.down
    remove_column :contacts, :team_status
  end
end
