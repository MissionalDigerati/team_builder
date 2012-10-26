class CreatePresences < ActiveRecord::Migration
  def change
    create_table :presences do |t|
      t.integer :contact_id
      t.string :site
      t.string :url
      t.string :account
      t.timestamps
    end
  end
end
