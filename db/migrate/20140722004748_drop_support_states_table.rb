class DropSupportStatesTable < ActiveRecord::Migration
  def up
    drop_table :support_states
  end

  def down
  end
end
