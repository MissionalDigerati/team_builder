class FixType < ActiveRecord::Migration
  def change
    rename_column :numbers, :type, :phone_type
  end
end
