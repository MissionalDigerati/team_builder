class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :day
      t.string :month
      t.string :year
      t.string :occasion
      t.timestamps
    end
  end
end
