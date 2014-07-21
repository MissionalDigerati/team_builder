class AddSentLetterToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :sent_letter, :boolean, default: false
  end
end
