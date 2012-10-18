class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :spouse_name
      t.string :email
      t.string :spouse_email
      t.string :tags
      t.string :network
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state_id
      t.string :zip
      t.string :country_id
      t.boolean :receive_newsletter, :default => false
      t.string :children
      t.string :prefered_contact
      t.timestamps
    end
  end
end
