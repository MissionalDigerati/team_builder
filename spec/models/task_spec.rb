require 'spec_helper'

describe Task do
  context "methods" do
    it "should return the correct number of incomplete tasks" do
      FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
      FactoryGirl.create(:defaulted_task, :completed => false, :task => "task2")
      FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")            
      Task.incomplete_tasks.should == 2
    end
    
    it "should reutrn 0 if no incomplete tasks exist" do
      FactoryGirl.create(:defaulted_task, :completed => true, :task => "task complete")
      Task.incomplete_tasks.should == 0
    end
    
  end
end
