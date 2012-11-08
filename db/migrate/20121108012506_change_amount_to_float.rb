class ChangeAmountToFloat < ActiveRecord::Migration
  def up
    change_column :donations, :amount, :float
  end

  def down
    change_column :donations, :amount, :string
  end
end
