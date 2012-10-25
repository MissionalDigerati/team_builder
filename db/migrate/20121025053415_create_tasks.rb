class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :contact_id
      t.boolean :completed, :default => false
      t.string :task
      t.string :due_date
      t.string :category
      t.timestamps
    end
  end
end
