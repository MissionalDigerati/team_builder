require 'spec_helper'

describe Task do
  context "incomplete_tasks method" do
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
  
  context "validataions" do
    it "should create a valid task" do
      FactoryGirl.build(:defaulted_task).should be_valid
    end
    
    it "should require task" do
      FactoryGirl.build(:defaulted_task, :task => "").should_not be_valid
    end
    
    it "should require due_date" do
      FactoryGirl.build(:defaulted_task, :due_date => nil).should_not be_valid
    end
    
    it "should require category" do
      FactoryGirl.build(:defaulted_task, :category => nil).should_not be_valid
    end
    
    it "should require contact_id" do
      FactoryGirl.build(:defaulted_task, :contact_id => nil).should_not be_valid
    end
    
  end
end
