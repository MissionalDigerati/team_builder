class ChangeDateOnOccasions < ActiveRecord::Migration
  def up
    remove_column :occasions, :day, :string
    remove_column :occasions, :month, :string
    remove_column :occasions, :year, :string
    add_column :occasions, :special_date, :date
    add_column :occasions, :incorrect_year, :boolean
  end

  def down
    add_column :occasions, :day, :string
    add_column :occasions, :month, :string
    add_column :occasions, :year, :string
    remove_column :occasions, :special_date, :date
    remove_column :occasions, :incorrect_year, :boolean
  end
end
