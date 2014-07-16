class ChangeColumnTypeForDueDateOnTasks < ActiveRecord::Migration

  def self.up
    add_column :tasks, :convert_due_date, :date
    
    # look up the schema's to be able to re-inspect the Task model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    Task.reset_column_information
    
    # loop over the collection
    Task.all.each do |d|
        d.convert_due_date = Date.parse(d.due_date)
        d.save
    end
    
    # remove the older status column
    remove_column :tasks, :due_date
    # rename the convert_status to status column
    rename_column :tasks, :convert_due_date, :due_date
  end

  def self.down
    add_column :tasks, :convert_due_date, :string
    
    # look up the schema's to be able to re-inspect the Task model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    Task.reset_column_information
    
    # loop over the collection
    Task.all.each do |d|
        d.convert_due_date = d.due_date.to_s
        d.save
    end
    
    # remove the older status column
    remove_column :tasks, :due_date
    # rename the convert_status to status column
    rename_column :tasks, :convert_due_date, :due_date
  end

end
