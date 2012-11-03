class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_long
      t.string :state_short

      t.timestamps
    end
  end
end
