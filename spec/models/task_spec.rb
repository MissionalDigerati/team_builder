require 'spec_helper'

describe Task do
  context "incomplete_tasks method" do

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

  context "methods" do


    context "#total_tasks" do

        it "should return the correct # of completed tasks" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            Task.total_tasks(:completed).should == 2
        end

        it "should return the correct # of incomplete tasks" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            Task.total_tasks(:incomplete).should == 1
        end

        it "should return the correct # of all tasks by default" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            Task.total_tasks.should == 3
        end

        it "should return the correct # of overdue tasks (ie. tasks overdue and incomplete)" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1", :due_date => 1.month.ago)
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task4")
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1", :due_date => 1.month.ago)
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3", :due_date => 1.month.ago)
            Task.total_tasks(:overdue).should == 2
        end

    end

    context "#is_overdue?" do

      it "should return true if the task is overdue" do
        task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3", :due_date => 1.month.ago)
        task.is_overdue?.should === true
      end

      it "should return false if the task is not overdue" do
        task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3", :due_date => 1.month.from_now)
        task.is_overdue?.should === false
      end

      it "should return false if the task is completed" do
        task = FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3", :due_date => 1.month.ago)
        task.is_overdue?.should === false
      end
    end

    context "#is_completed?" do

        it "should return true if it is completed" do
            task = FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            task.is_completed?.should === true
        end

        it "should return false if it is incomplete" do
            task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3")
            task.is_completed?.should === false
        end
    end

  end
end
