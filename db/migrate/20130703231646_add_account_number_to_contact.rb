class AddAccountNumberToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :account_number, :string
  end
end
