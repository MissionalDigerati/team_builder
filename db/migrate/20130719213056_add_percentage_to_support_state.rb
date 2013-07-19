class AddPercentageToSupportState < ActiveRecord::Migration
  def up
  	add_column :support_states, :progress_percent, :integer
  end

  def down
  	remove_column :support_states, :progress_percent
  end
end
