class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.boolean :completed
      t.string :task
      t.string :due_date
      t.string :category
      t.timestamps
    end
  end
end
