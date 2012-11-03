class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso
      t.string :name
      t.string :printable_name
      t.string :iso3
      t.integer :numcode

      t.timestamps
    end
  end
end
