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

    it "should return the current date" do
      Task.current_date.should == Time.now.to_date
    end

    it "should not return anything other than the current date" do
      Task.current_date.should_not == 1.weeks.from_now.to_date
    end

    it "shoud return tomorrows date" do
      Task.tomorrows_date.should == 1.days.from_now.to_date
    end

    it "shoud return the date one week from today" do
      Task.next_weeks_date.should == 1.weeks.from_now.to_date
    end

    it "should return the date 4 weeks from today" do
      Task.next_4_weeks_date.should == 4.weeks.from_now.to_date
    end

    it "should return the number that corresponds with the current day" do
      Task.current_day_number.should == Time.now.day
    end

    it "should return the number that corresponds with the current month" do
      Task.current_month_number.should == Time.now.month
    end

    it "should return the current year in number for as a string" do
      Task.current_year.should == Time.now.year.to_s
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
