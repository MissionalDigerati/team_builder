class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :contact_id
      t.string :date
      t.string :amount
      t.string :project                  
      t.timestamps
    end
  end
end
